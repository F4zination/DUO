package api

import (
	"log"

	"github.com/duo/pb"
)

func (server *Server) GetNotificationStream(req *pb.TokenOnlyRequest, stream pb.DUOService_GetNotificationStreamServer) error {
	payload, verifyErr := server.Maker.VerifyToken(req.Token)
	if verifyErr != nil {
		log.Printf("Error verifying token %v", verifyErr)
		return verifyErr
	}

	err := server.UserNotificationHandler.AddUserStream(payload.UserID.String(), stream)
	if err != nil {
		log.Printf("Error adding user stream: %v", err)
		return err
	}

	err = server.UserNotificationHandler.SendMessageToUser(payload.UserID.String(), &pb.Notification{
		Type: pb.NotificationType_SIMPLE_MESSAGE,
		Data: "Welcome to the notification stream!"},
	)
	if err != nil {
		log.Printf("Error removing user stream: %v", err)
	}

	return nil
}
