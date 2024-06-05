package api

import (
	"context"
	"log"

	"github.com/duo/pb"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (server *Server) GetGameState(req *pb.GetGameStateRequest, stream pb.DUOService_GetGameStateServer) error {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		log.Printf("error verifying token: %v", tokenErr)
		return status.Errorf(codes.Unauthenticated, "invalid token")
	}

	// Check if user is in game
	userIds, userGetErr := server.Store.GetPlayersInGame(context.Background(), int32(req.GameId))
	if userGetErr != nil {
		log.Printf("error getting players in game: %v", userGetErr)
		return status.Errorf(codes.Internal, "error getting players in game")
	}

	userInGame := false
	for _, id := range userIds {
		if id.PlayerID == payload.UserID {
			userInGame = true
			break
		}
	}

	if !userInGame {
		return status.Errorf(codes.PermissionDenied, "user not in game")
	}

	_, exists := server.GameHandler.GetGame(int(req.GameId))
	if !exists {
		log.Printf("game does not exist")
		return status.Errorf(codes.NotFound, "game does not exist")
	}

	// Add user to game
	addErr := server.GameHandler.AddGameStateStream(int(req.GameId), payload.UserID, stream)
	if addErr != nil {
		log.Printf("error adding user to game: %v", addErr)
		return status.Errorf(codes.Internal, "error adding user to game")
	}

	return nil
}

func (server *Server) GetStackStream(stream pb.DUOService_GetStackStreamServer) error {
	msg, err := stream.Recv()
	if err != nil {
		log.Printf("error receiving message: %v", err)
		return status.Errorf(codes.Internal, "error receiving message")
	}

	log.Printf("Received Stack message with gameId: %v", msg.GameId)

	payload, tokenErr := server.Maker.VerifyToken(msg.Token)
	if tokenErr != nil {
		log.Printf("error verifying token: %v", tokenErr)
		return status.Errorf(codes.Unauthenticated, "invalid token")
	}

	gameId, getErr := server.Store.GetPlayersGameId(context.Background(), payload.UserID)
	if getErr != nil {
		log.Printf("error getting players game id: %v", getErr)
		return status.Errorf(codes.Internal, "error getting players game id")
	}

	// Add user to game
	addErr := server.GameHandler.SetStackStream(int(gameId.GameID), payload.UserID, stream)
	if addErr != nil {
		log.Printf("error adding user to game: %v", addErr)
		return status.Errorf(codes.Internal, "error adding user to game")
	}

	return nil
}

func (server *Server) GetPlayerStream(stream pb.DUOService_GetPlayerStreamServer) error {
	msg, err := stream.Recv()
	if err != nil {
		log.Printf("error receiving message: %v", err)
		return status.Errorf(codes.Internal, "error receiving message")
	}

	payload, tokenErr := server.Maker.VerifyToken(msg.Token)
	if tokenErr != nil {
		log.Printf("error verifying token: %v", tokenErr)
		return status.Errorf(codes.Unauthenticated, "invalid token")
	}

	log.Printf("Received PlayerAction message: %v", msg.Action)

	gameId, getErr := server.Store.GetPlayersGameId(context.Background(), payload.UserID)
	if getErr != nil {
		log.Printf("error getting players game id: %v", getErr)
		return status.Errorf(codes.Internal, "error getting players game id")
	}

	log.Printf("Game ID: %v", gameId.GameID)

	// Add user to game
	addErr := server.GameHandler.AddPlayerStream(int(gameId.GameID), payload.UserID, stream)
	if addErr != nil {
		log.Printf("error adding user to game: %v", addErr)
		return status.Errorf(codes.Internal, "error adding user to game")
	}

	return nil
}
