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

type LobbyManager struct {
	LobbyStreams map[int][]UserStream
	store        db.Store
	Mu           sync.Mutex
}

func NewLobbyManager(store db.Store) *LobbyManager {
	return &LobbyManager{
		LobbyStreams: make(map[int][]UserStream),
		store:        store,
		Mu:           sync.Mutex{},
	}
}

// func (sm *SessionManager) SendTestMessagesToAll() {
// 	//Send messages to all clients in all sessions with a 1 second interval
// 	go func() {
// 		for {
// 			log.Printf("sending test message to sessions: %v", sm.SessionStreams)
// 			for sessionId, _ := range sm.SessionStreams {
// 				users, usersErr := sm.GetUsersInSession(sessionId)
// 				if usersErr != nil {
// 					log.Printf("error getting users in session %d: %v", sessionId, usersErr)
// 					continue
// 				}
// 				sm.SendMessage(sessionId, &pb.SessionStream{
// 					SessionId: int32(sessionId),
// 					GameState: &pb.GameState{},
// 					SessionState: &pb.SessionState{
// 						Users: users,
// 					},
// 				})
// 			}
// 			time.Sleep(1 * time.Second)
// 		}
// 	}()
// }

func (sm *LobbyManager) CreateLobby(userUUID uuid.UUID, maxPlayers int32) (*db.Lobby, error) {
	dbSession, createErr := sm.store.CreateLobby(context.Background(), db.CreateLobbyParams{
		OwnerID:    userUUID,
		MaxPlayers: maxPlayers,
	})
	if createErr != nil {
		return nil, createErr
	}

	sm.Mu.Lock()

	sm.LobbyStreams[int(dbSession.ID)] = []UserStream{}

	sm.Mu.Unlock()

	return &dbSession, nil
}

func (sm *LobbyManager) GetUsersInLobby(lobbyId int) ([]*pb.User, error) {

	dbSession, getErr := sm.store.GetLobbyByID(context.Background(), int32(lobbyId))
	if getErr != nil {
		return []*pb.User{}, getErr
	}

	sm.Mu.Lock()
	defer sm.Mu.Unlock()
	//Session must exist
	if sm.LobbyStreams[lobbyId] == nil {
		return []*pb.User{}, fmt.Errorf("session does not exist")
	}

	var users []*pb.User
	for _, s := range sm.LobbyStreams[lobbyId] {
		users = append(users, &pb.User{
			Uuid:    s.UserId.String(),
			Name:    s.Username,
			IsAdmin: dbSession.OwnerID == s.UserId,
		})

	}

	return users, nil
}

func (sm *LobbyManager) GetLobby(lobbyId int) ([]UserStream, error) {
	return sm.LobbyStreams[lobbyId], nil
}

func (sm *LobbyManager) SendMessageToLobby(lobbyId int, message *pb.LobbyStatus) []error {
	//Session must exist
	if sm.LobbyStreams[lobbyId] == nil {
		return []error{fmt.Errorf("session does not exist")}
	}

	var errs []error

	for _, s := range sm.LobbyStreams[lobbyId] {
		log.Printf("sending message to session %d", lobbyId)
		err := s.Stream.Send(message)
		if err != nil {
			errs = append(errs, err)
			log.Printf("error sending message to session %d: %v", lobbyId, err)
		}
	}

	return errs
}

func (sm *LobbyManager) DeleteLobby(lobbyId int) error {
	_, delErr := sm.store.DeleteLobbyByID(context.Background(), int32(lobbyId))
	if delErr != nil {
		return delErr
	}

	sm.Mu.Lock()
	defer sm.Mu.Unlock()

	for _, s := range sm.LobbyStreams[lobbyId] {
		//TODO Close client connection correctly
		s.Stream.Context().Done()
	}
	delete(sm.LobbyStreams, lobbyId)

	return nil
}

func (sm *LobbyManager) GetLobbyStreams(sessionId int) ([]UserStream, error) {
	return sm.LobbyStreams[sessionId], nil
}

func (sm *LobbyManager) AddStreamToLobby(lobbyId int, stream UserStream) error {

	//Stream must exist
	if sm.LobbyStreams[lobbyId] == nil {
		return fmt.Errorf("session does not exist")
	}

	//Stream must be unique
	for _, s := range sm.LobbyStreams[lobbyId] {
		if s.UserId == stream.UserId {
			return fmt.Errorf("stream already exists in session")
		}
	}

	sm.Mu.Lock()
	sm.LobbyStreams[lobbyId] = append(sm.LobbyStreams[lobbyId], stream)
	sm.Mu.Unlock()

	users, userErr := sm.GetUsersInLobby(lobbyId)
	if userErr != nil {
		return userErr
	}

	sm.SendMessageToLobby(lobbyId, &pb.LobbyStatus{
		Users:      users,
		IsStarting: false,
	})

	log.Printf("Added user stream %v to session %d", stream.UserId, lobbyId)

	//Wait for client to disconnect
	<-stream.Stream.Context().Done()

	log.Printf("Client %v disconnected", stream.UserId)
	sm.RemoveStreamFromLobby(lobbyId, stream.UserId)
	return nil
}

func (sm *LobbyManager) RemoveStreamFromLobby(lobbyId int, userId uuid.UUID) error {
	//Stream must exist
	if sm.LobbyStreams[lobbyId] == nil {
		return fmt.Errorf("lobby does not exist")
	}

	dbLobby, getErr := sm.store.GetLobbyByID(context.Background(), int32(lobbyId))
	if getErr != nil {
		return getErr
	}

	if userId == dbLobby.OwnerID {
		log.Printf("Owner %v disconnected and lobby %d deleted", userId, lobbyId)
		sm.DeleteLobby(lobbyId)
		return nil
	}

	newStreams := []UserStream{}
	for _, s := range sm.LobbyStreams[lobbyId] {
		if s.UserId != userId {
			newStreams = append(newStreams, s)
		} else {
			s.Stream.Context().Done()
		}
	}
	sm.Mu.Lock()
	sm.LobbyStreams[lobbyId] = newStreams
	sm.Mu.Unlock()

	users, userErr := sm.GetUsersInLobby(lobbyId)
	if userErr != nil {
		return userErr
	}

	sm.SendMessageToLobby(lobbyId, &pb.LobbyStatus{
		Users:      users,
		IsStarting: false,
	})

	log.Printf("Removed user stream %v from session %d", userId, lobbyId)
	return nil
}
