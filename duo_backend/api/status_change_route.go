package api

import (
	"context"
	"io"
	"log"

	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/google/uuid"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func setOffline(store db.Store, userID uuid.UUID) {
	_, dbErr := store.UpdateUserStatus(context.Background(), db.UpdateUserStatusParams{
		Uuid:       userID,
		UserStatus: db.UserstatusOffline,
	})
	if dbErr != nil {
		log.Printf("Could not update user status to offline: %v", dbErr)
	}
	log.Printf("Stream context done for user: %v", userID)
}

func sendResponseMessage(stream pb.DUOService_StatusChangeStreamServer) error {
	log.Printf("Sending response message")
	if err := stream.Send(&pb.Void{}); err != nil {
		log.Printf("Error sending response message: %v", err)
		return err
	}
	return nil
}

func (server *Server) StatusChangeStream(stream pb.DUOService_StatusChangeStreamServer) error {
	var userID uuid.UUID

	// Immediately send an empty acknowledgement message
	if err := sendResponseMessage(stream); err != nil {
		return err
	}

	for {
		select {
		case <-stream.Context().Done():
			setOffline(server.Store, userID)
			return nil
		default: // Add default case for non-blocking Recv()
			if stream == nil {
				return status.Errorf(codes.Internal, "Stream not initialized")
			}
			msg, err := stream.Recv()
			if userID == uuid.Nil && err == nil {
				payload, verifyErr := server.Maker.VerifyToken(msg.Token)
				if verifyErr != nil {
					log.Printf("Error verifying token %v", verifyErr)
					return verifyErr
				}
				userID = payload.UserID
			}
			if err != nil {
				if err == io.EOF {
					log.Printf("Stream closed for user: %v", userID)
					setOffline(server.Store, userID)
					return nil
				} else if status.Code(err) == codes.Canceled { // Check for context cancellation
					log.Printf("Context canceled for user: %v", userID)
					setOffline(server.Store, userID)
					return nil // Or handle it differently as needed
				}
				log.Printf("Error receiving message for user %v: %v", userID, err)
				setOffline(server.Store, userID)
				return err
			}
			if len(userID.String()) == 0 {
				log.Printf("Error could not receive userID for userstatusUpdate")
				setOffline(server.Store, userID)
				return err
			}

			log.Printf("Received message for user %v: %v", userID, msg)
			_, dbErr := server.Store.UpdateUserStatus(context.Background(), db.UpdateUserStatusParams{
				Uuid:       userID,
				UserStatus: toUserState(msg.Status),
			})
			if dbErr != nil {
				log.Printf("Error updating user status: %v", err)
				return err
			}
			// send an empty acknowledgement message
			if err := sendResponseMessage(stream); err != nil {
				return err
			}
		}
	}
}
