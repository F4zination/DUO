package api

import (
	"context"
	"fmt"
	"log"
	"sync"

	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/google/uuid"
)

type UserStream struct {
	Stream   pb.DUOService_JoinLobbyServer
	UserId   uuid.UUID
	Username string
}

func NewUserStream(stream pb.DUOService_JoinLobbyServer, userId uuid.UUID, username string) *UserStream {
	return &UserStream{
		Stream:   stream,
		Username: username,
		UserId:   userId,
	}
}

type Lobby struct {
	UserStreams []UserStream
	Mu          sync.RWMutex
}

type LobbyManager struct {
	LobbyStreams map[int]*Lobby
	store        db.Store
	Mu           sync.RWMutex
}

func NewLobbyManager(store db.Store) *LobbyManager {
	return &LobbyManager{
		LobbyStreams: make(map[int]*Lobby),
		store:        store,
		Mu:           sync.RWMutex{},
	}
}

func (sm *LobbyManager) CreateLobby(userUUID uuid.UUID, stackUUID uuid.UUID, maxPlayers int32) (*db.Lobby, error) {
	dbSession, createErr := sm.store.CreateLobby(context.Background(), db.CreateLobbyParams{
		OwnerID:    userUUID,
		MaxPlayers: maxPlayers,
		StackID:    stackUUID,
	})
	if createErr != nil {
		return nil, createErr
	}

	sm.Mu.Lock()
	sm.LobbyStreams[int(dbSession.ID)] = &Lobby{}
	sm.Mu.Unlock()

	return &dbSession, nil
}

func (sm *LobbyManager) GetUsersInLobby(lobbyId int) ([]*pb.User, error) {

	dbSession, getErr := sm.store.GetLobbyByID(context.Background(), int32(lobbyId))
	if getErr != nil {
		return []*pb.User{}, getErr
	}

	lobby, lobbyErr := sm.GetLobby(lobbyId)
	if lobbyErr != nil {
		return []*pb.User{}, lobbyErr
	}

	lobby.Mu.RLock()
	var users []*pb.User
	for _, s := range lobby.UserStreams {
		users = append(users, &pb.User{
			Uuid:    s.UserId.String(),
			Name:    s.Username,
			IsAdmin: dbSession.OwnerID == s.UserId,
		})
	}
	lobby.Mu.RUnlock()

	return users, nil
}

func (sm *LobbyManager) GetLobby(lobbyId int) (*Lobby, error) {
	sm.Mu.RLock()
	lobby, exists := sm.LobbyStreams[lobbyId]
	sm.Mu.RUnlock()

	if !exists {
		return nil, fmt.Errorf("lobby does not exist")
	}

	return lobby, nil
}

func (sm *LobbyManager) SendMessageToLobby(lobbyId int, message *pb.LobbyStatus) []error {
	//Session must exist

	lobby, lobbyErr := sm.GetLobby(lobbyId)
	if lobbyErr != nil {
		return []error{lobbyErr}
	}

	log.Printf("Sending message to session %d", lobbyId)

	var errs []error
	lobby.Mu.RLock()

	for _, s := range lobby.UserStreams {
		log.Printf("sending message to session %d", lobbyId)
		err := s.Stream.Send(message)
		if err != nil {
			errs = append(errs, err)
			log.Printf("error sending message to session %d: %v", lobbyId, err)
		}
	}
	lobby.Mu.RUnlock()

	return errs
}

func (sm *LobbyManager) DeleteLobby(lobbyId int) error {
	fmt.Printf("Deleting lobby %d", lobbyId)
	sm.Mu.Lock()
	_, delErr := sm.store.DeleteLobbyByID(context.Background(), int32(lobbyId))
	sm.Mu.Unlock()
	if delErr != nil {
		log.Printf("error deleting session %d: %v", lobbyId, delErr)
		return delErr
	}

	delete(sm.LobbyStreams, lobbyId)

	return nil
}

func (sm *LobbyManager) AddStreamToLobby(lobbyId int, stream UserStream) error {

	userId := stream.UserId

	sm.Mu.RLock()
	lobby, exists := sm.LobbyStreams[lobbyId]
	sm.Mu.RUnlock()

	if !exists {
		return fmt.Errorf("lobby does not exist")
	}

	lobby.Mu.RLock()
	//Stream must be unique
	for _, s := range lobby.UserStreams {
		if s.UserId == userId {
			return fmt.Errorf("stream already exists in session")
		}
	}
	lobby.Mu.RUnlock()

	lobby.Mu.Lock()
	lobby.UserStreams = append(lobby.UserStreams, stream)
	lobby.Mu.Unlock()

	users, userErr := sm.GetUsersInLobby(lobbyId)
	if userErr != nil {
		log.Printf("error getting users in session %d: %v", lobbyId, userErr)
		return userErr
	}

	dbLobby, getErr := sm.store.GetLobbyByID(context.Background(), int32(lobbyId))
	if getErr != nil {
		log.Printf("error getting session %d: %v", lobbyId, getErr)
		return getErr
	}

	err := sm.SendMessageToLobby(lobbyId, &pb.LobbyStatus{
		Users:      users,
		IsStarting: false,
		LobbyId:    int32(lobbyId),
		MaxPlayers: dbLobby.MaxPlayers,
	})
	if err != nil {
		log.Printf("error sending message to session %d: %v", lobbyId, err[0])
		return err[0]
	}

	log.Printf("Added user stream %v to session %d", userId, lobbyId)

	// Wait for client to disconnect
	<-stream.Stream.Context().Done()

	log.Printf("Client %v disconnected", userId)
	removingErr := sm.RemoveStreamFromLobby(lobbyId, userId)
	if removingErr != nil {
		log.Printf("error removing user stream %v from session %d: %v", userId, lobbyId, removingErr)
		return removingErr
	}
	return nil
}

func (sm *LobbyManager) RemoveStreamFromLobby(lobbyId int, userId uuid.UUID) error {
	//Stream must exist
	sm.Mu.RLock()
	lobby, exists := sm.LobbyStreams[lobbyId]
	sm.Mu.RUnlock()

	if !exists {
		return fmt.Errorf("lobby does not exist")
	}

	if lobby.UserStreams == nil || len(lobby.UserStreams) == 0 {
		return fmt.Errorf("lobby does not exist")
	}

	fmt.Printf("Removing user %v from lobby %d", userId, lobbyId)

	dbLobby, getErr := sm.store.GetLobbyByID(context.Background(), int32(lobbyId))
	if getErr != nil {
		return getErr
	}

	lobby.Mu.RLock()

	newStreams := []UserStream{}
	for _, s := range lobby.UserStreams {
		if s.UserId != userId {
			newStreams = append(newStreams, s)
		}
	}

	lobby.Mu.RUnlock()

	lobby.Mu.Lock()
	lobby.UserStreams = newStreams
	lobby.Mu.Unlock()

	if userId == dbLobby.OwnerID {
		sm.DeleteLobby(lobbyId)
		log.Printf("Owner %v disconnected and lobby %d deleted", userId, lobbyId)
		return nil
	}

	users, userErr := sm.GetUsersInLobby(lobbyId)
	if userErr != nil {
		return userErr
	}
	sm.SendMessageToLobby(lobbyId, &pb.LobbyStatus{
		Users:      users,
		IsStarting: false,
		LobbyId:    int32(lobbyId),
		MaxPlayers: dbLobby.MaxPlayers,
	})

	log.Printf("Removed user stream %v from session %d", userId, lobbyId)
	return nil
}
