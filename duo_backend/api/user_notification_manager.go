package api

import (
	"context"
	"database/sql"
	"log"
	"sync"

	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/google/uuid"
)

func toMessageType(str string) pb.NotificationType {
	switch str {
	case pb.NotificationType_SIMPLE_MESSAGE.String():
		return pb.NotificationType_SIMPLE_MESSAGE
	case pb.NotificationType_FRIEND_REQUEST.String():
		return pb.NotificationType_FRIEND_REQUEST
	default:
		return pb.NotificationType_SIMPLE_MESSAGE
	}
}

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
	Stream pb.DUOService_GetNotificationStreamServer
	UserID string
}

func NewUserStateStream(stream pb.DUOService_GetNotificationStreamServer, userID string) *UserStateStream {
	return &UserStateStream{
		Stream: stream,
		UserID: userID,
	}
}

func (usm *UserNotificationManager) AddUserStream(userID string, stream pb.DUOService_GetNotificationStreamServer) error {
	usm.Mu.Lock()
	usm.UserStates[userID] = *NewUserStateStream(stream, userID)
	usm.Mu.Unlock()

	err := usm.store.ExecTx(context.Background(), sql.LevelDefault, func(q *db.Queries) error {
		parsedUuid, parseErr := uuid.Parse(userID)
		if parseErr != nil {
			log.Printf("Error parsing UUID: %v", parseErr)
			return parseErr
		}
		notifications, err := q.GetNotificationsByUserId(context.Background(), parsedUuid)
		if err != nil && err != sql.ErrNoRows {
			log.Printf("Error getting notifications by user ID: %v", err)
			return err
		}
		for _, notification := range notifications {
			err := stream.Send(&pb.Notification{
				Type: toMessageType(notification.MessageType),
				Data: notification.Message,
			})
			if err != nil {
				log.Printf("Error sending notification: %v", err)
				return err
			}
		}

		_, err = q.ClearNotificationsByUserId(context.Background(), parsedUuid)
		if err != nil {
			log.Printf("Error clearing notifications by user ID: %v", err)
			return err
		}
		return nil
	})

	if err != nil {
		log.Printf("Error executing transaction: %v", err)
		return err
	}

	// Listen for context cancellation
	<-stream.Context().Done()
	err = usm.RemoveUserStream(userID)
	return err
}

func (usm *UserNotificationManager) RemoveUserStream(userID string) error {
	usm.Mu.Lock()
	delete(usm.UserStates, userID)
	usm.Mu.Unlock()
	return nil
}

// returns the UserStateStream for a given userID and a boolean indicating if the user stream exists
func (usm *UserNotificationManager) GetUserStream(userID string) (UserStateStream, bool) {
	usm.Mu.RLock()
	stream, ok := usm.UserStates[userID]
	usm.Mu.RUnlock()
	if !ok {
		return UserStateStream{}, false
	}
	return stream, true
}

func (usm *UserNotificationManager) SendMessageToUser(userID string, notification *pb.Notification) error {
	userStream, exists := usm.GetUserStream(userID)
	if !exists {
		//add to db
		parsedUuid, parseErr := uuid.Parse(userID)
		if parseErr != nil {
			log.Printf("Error parsing UUID: %v", parseErr)
			return parseErr
		}
		_, err := usm.store.CreateNotification(context.Background(), db.CreateNotificationParams{
			UserID:      parsedUuid,
			Message:     notification.Data,
			MessageType: notification.Type.String(),
		})
		if err != nil {
			log.Printf("Error creating notification: %v", err)
			return err
		}
	}
	//send to user and do NOT add to db
	err := userStream.Stream.Send(notification)
	if err != nil {
		return err
	}
	return nil
}
