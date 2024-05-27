package api

import (
	"context"
	"io"
	"log"
	"sync"

	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/google/uuid"
)

// UserNotificationManager is a struct that holds the state of all users, who are currently online
// and in what state they are in
type UserNotificationManager struct {
	UserStates map[string]UserStateStream
	store      db.Store
	Mu         sync.RWMutex
}

func NewUserNotificationManager(store db.Store) *UserNotificationManager {
	return &UserNotificationManager{
		UserStates: make(map[string]UserStateStream),
		store:      store,
		Mu:         sync.RWMutex{},
	}
}

type UserStateStream struct {
	Stream pb.DUOService_StatusChangeStreamServer
	UserID string
}

func NewUserStateStream(stream pb.DUOService_StatusChangeStreamServer, userID string) *UserStateStream {
	return &UserStateStream{
		Stream: stream,
		UserID: userID,
	}
}

func (usm *UserNotificationManager) AddUserStream(userID string, stream pb.DUOService_StatusChangeStreamServer) error {
	usm.Mu.Lock()
	usm.UserStates[userID] = *NewUserStateStream(stream, userID)
	usm.Mu.Unlock()

	for {
		select {
		case <-stream.Context().Done():
			err := usm.RemoveUserStream(userID)
			if err != nil {
				log.Printf("Error removing user stream: %v", err)
				return err
			}
			log.Printf("Stream context done for user: %v", userID)
			return nil
		default: // Add default case for non-blocking Recv()
			msg, err := stream.Recv()
			if err != nil {
				if err == io.EOF {
					log.Printf("Stream closed for user: %v", userID)
					return nil
				}
				log.Printf("Error receiving message for user %v: %v", userID, err)
				return err
			}

			log.Printf("Received message for user %v: %v", userID, msg)
			err = usm.UpdateUserStatus(userID, toUserState(msg.Status))
			if err != nil {
				log.Printf("Error updating user status: %v", err)
				return err
			}
		}
	}
}

func (usm *UserNotificationManager) RemoveUserStream(userID string) error {
	usm.Mu.Lock()
	delete(usm.UserStates, userID)
	usm.Mu.Unlock()

	parsedUuid, uuidErr := uuid.Parse(userID)
	if uuidErr != nil {
		log.Printf("error parsing uuid: %v", uuidErr)
		return uuidErr
	}

	_, err := usm.store.UpdateUserStatus(context.Background(), db.UpdateUserStatusParams{
		Uuid:       parsedUuid,
		UserStatus: db.UserstatusOffline,
	})

	if err != nil {
		log.Printf("error updating user status: %v", err)
		return err
	}
	return nil
}

func (usm *UserNotificationManager) GetUserStream(userID string) UserStateStream {
	usm.Mu.RLock()
	defer usm.Mu.RUnlock()
	return usm.UserStates[userID]
}

func (usm *UserNotificationManager) UpdateUserStatus(userID string, userStatus db.Userstatus) error {
	userUuid, uuidErr := uuid.Parse(userID)
	if uuidErr != nil {
		log.Printf("error parsing uuid: %v", uuidErr)
		return uuidErr
	}

	_, dbErr := usm.store.UpdateUserStatus(context.Background(), db.UpdateUserStatusParams{
		Uuid:       userUuid,
		UserStatus: userStatus,
	})
	if dbErr != nil {
		log.Printf("error updating user status: %v", dbErr)
		return dbErr
	}
	return nil
}
