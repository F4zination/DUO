package api

import (
	"context"
	"fmt"
	"log"
	"sync"
	"time"

	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/google/uuid"
)

type UserStream struct {
	Stream   pb.DUOService_JoinSessionServer
	UserId   uuid.UUID
	Username string
}

func NewUserStream(stream pb.DUOService_JoinSessionServer, userId uuid.UUID, username string) *UserStream {
	return &UserStream{
		Stream:   stream,
		Username: username,
		UserId:   userId,
	}
}

type SessionManager struct {
	SessionStreams map[int][]UserStream
	store          db.Store
	Mu             sync.Mutex
}

func NewSessionManager(store db.Store) *SessionManager {
	return &SessionManager{
		SessionStreams: make(map[int][]UserStream),
		store:          store,
		Mu:             sync.Mutex{},
	}
}

func (sm *SessionManager) SendTestMessagesToAll() {
	//Send messages to all clients in all sessions with a 1 second interval
	go func() {
		for {
			log.Printf("sending test message to sessions: %v", sm.SessionStreams)
			for sessionId, _ := range sm.SessionStreams {
				users, usersErr := sm.GetUsersInSession(sessionId)
				if usersErr != nil {
					log.Printf("error getting users in session %d: %v", sessionId, usersErr)
					continue
				}
				sm.SendMessage(sessionId, &pb.SessionStream{
					SessionId: int32(sessionId),
					GameState: &pb.GameState{},
					SessionState: &pb.SessionState{
						Users: users,
					},
				})
			}
			time.Sleep(1 * time.Second)
		}
	}()
}

func (sm *SessionManager) CreateSession(userUUID uuid.UUID, pin string, maxPlayers int32) (*db.GameSession, error) {
	dbSession, createErr := sm.store.CreateSession(context.Background(), db.CreateSessionParams{
		OwnerID:    userUUID,
		Pin:        pin,
		MaxPlayers: maxPlayers,
	})
	if createErr != nil {
		return nil, createErr
	}

	sm.Mu.Lock()

	sm.SessionStreams[int(dbSession.ID)] = []UserStream{}

	sm.Mu.Unlock()

	return &dbSession, nil
}

func (sm *SessionManager) GetUsersInSession(sessionId int) ([]*pb.User, error) {

	dbSession, getErr := sm.store.GetSessionByID(context.Background(), int32(sessionId))
	if getErr != nil {
		return []*pb.User{}, getErr
	}

	sm.Mu.Lock()
	defer sm.Mu.Unlock()
	//Session must exist
	if sm.SessionStreams[sessionId] == nil {
		return []*pb.User{}, fmt.Errorf("session does not exist")
	}

	var users []*pb.User
	for _, s := range sm.SessionStreams[sessionId] {
		users = append(users, &pb.User{
			Uuid:    s.UserId.String(),
			Name:    s.Username,
			IsAdmin: dbSession.OwnerID == s.UserId,
		})

	}

	return users, nil
}

func (sm *SessionManager) GetSession(sessionId int) ([]UserStream, error) {
	return sm.SessionStreams[sessionId], nil
}

func (sm *SessionManager) SendMessage(sessionId int, message *pb.SessionStream) []error {
	//Session must exist
	if sm.SessionStreams[sessionId] == nil {
		return []error{fmt.Errorf("session does not exist")}
	}

	var errs []error

	for _, s := range sm.SessionStreams[sessionId] {
		log.Printf("sending message to session %d", sessionId)
		err := s.Stream.Send(message)
		if err != nil {
			errs = append(errs, err)
			log.Printf("error sending message to session %d: %v", sessionId, err)
		}
	}

	return errs
}

func (sm *SessionManager) DeleteSession(sessionId int) error {
	_, delErr := sm.store.DeleteSessionByID(context.Background(), int32(sessionId))
	if delErr != nil {
		return delErr
	}

	sm.Mu.Lock()
	defer sm.Mu.Unlock()

	for _, s := range sm.SessionStreams[sessionId] {
		//TODO Close client connection correctly
		s.Stream.Context().Done()
	}
	delete(sm.SessionStreams, sessionId)

	return nil
}

func (sm *SessionManager) GetSessionStreams(sessionId int) ([]UserStream, error) {
	return sm.SessionStreams[sessionId], nil
}

func (sm *SessionManager) AddStreamToSession(sessionId int, stream UserStream) error {

	//Stream must exist
	if sm.SessionStreams[sessionId] == nil {
		return fmt.Errorf("session does not exist")
	}

	//Stream must be unique
	for _, s := range sm.SessionStreams[sessionId] {
		if s.UserId == stream.UserId {
			return fmt.Errorf("stream already exists in session")
		}
	}

	sm.Mu.Lock()
	sm.SessionStreams[sessionId] = append(sm.SessionStreams[sessionId], stream)
	sm.Mu.Unlock()

	log.Printf("Added user stream %v to session %d", stream.UserId, sessionId)

	//Wait for client to disconnect
	<-stream.Stream.Context().Done()

	log.Printf("Client %v disconnected", stream.UserId)
	sm.RemoveStreamFromSession(sessionId, stream.UserId)
	return nil
}

func (sm *SessionManager) RemoveStreamFromSession(sessionId int, userId uuid.UUID) error {
	//Stream must exist
	if sm.SessionStreams[sessionId] == nil {
		return fmt.Errorf("session does not exist")
	}

	dbSession, getErr := sm.store.GetSessionByID(context.Background(), int32(sessionId))
	if getErr != nil {
		return getErr
	}

	if userId == dbSession.OwnerID {
		log.Printf("Owner %v disconnected and session %d deleted", userId, sessionId)
		sm.DeleteSession(sessionId)
		return nil
	}

	newStreams := []UserStream{}
	for _, s := range sm.SessionStreams[sessionId] {
		if s.UserId != userId {
			newStreams = append(newStreams, s)
		} else {
			s.Stream.Context().Done()
		}
	}

	sm.Mu.Lock()
	sm.SessionStreams[sessionId] = newStreams
	sm.Mu.Unlock()

	log.Printf("Removed user stream %v from session %d", userId, sessionId)
	return nil
}
