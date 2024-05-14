package api

import (
	"context"
	"database/sql"
	"fmt"
	"log"

	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/google/uuid"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (server *Server) CreateLobby(req *pb.CreateLobbyRequest, stream pb.DUOService_CreateLobbyServer) error {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		return status.Errorf(codes.Unauthenticated, "invalid token")
	}

	_, getErr := server.Store.GetLobbyByOwnerUUID(context.Background(), payload.UserID)
	if getErr != sql.ErrNoRows {
		return status.Errorf(codes.AlreadyExists, "user already owns a session")
	}

	lobby, createErr := server.LobbyHandler.CreateLobby(payload.UserID, payload.UserID, req.MaxPlayers)
	if createErr != nil {
		log.Printf("error creating session: %v", createErr)
		return status.Errorf(codes.Internal, "error creating session")
	}

	fmt.Printf("%v", server.LobbyHandler.LobbyStreams)

	addErr := server.LobbyHandler.AddStreamToLobby(int(lobby.ID), *NewUserStream(stream, payload.UserID, payload.Username))
	if addErr != nil {
		log.Printf("error adding user to session: %v", addErr)
		return status.Errorf(codes.Internal, "error adding user to session")
	}
	return nil
}

func (server *Server) JoinLobby(req *pb.JoinLobbyRequest, stream pb.DUOService_JoinLobbyServer) error {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		return status.Errorf(codes.Unauthenticated, "invalid token")
	}

	lobby, getErr := server.Store.GetLobbyByID(context.Background(), req.LobbyId)
	if getErr != nil {
		if getErr == sql.ErrNoRows {
			return status.Errorf(codes.NotFound, "session not found")
		}
		return status.Errorf(codes.Internal, "error getting session")
	}

	server.LobbyHandler.AddStreamToLobby(int(req.LobbyId), *NewUserStream(stream, payload.UserID, payload.Username))

	users, usersErr := server.LobbyHandler.GetUsersInLobby(int(req.LobbyId))
	if usersErr != nil {
		return status.Errorf(codes.Internal, "error getting users in session")
	}

	if int32(len(users)) >= lobby.MaxPlayers {
		return status.Errorf(codes.PermissionDenied, "session is full")
	}

	return nil
}

func (server *Server) ChangeStackDevice(ctx context.Context, req *pb.ChangeStackDeviceRequest) (*pb.Void, error) {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		log.Printf("error verifying token: %v", tokenErr)
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	//Is token lobby owner
	lobby, getErr := server.Store.GetLobbyByOwnerUUID(context.Background(), payload.UserID)
	if getErr != nil {
		if getErr == sql.ErrNoRows {
			return nil, status.Errorf(codes.PermissionDenied, "user is not lobby owner")
		}
		log.Printf("error getting lobby: %v", getErr)
		return nil, status.Errorf(codes.Internal, "error getting lobby")
	}

	//Is user in lobby
	_, userErr := server.LobbyHandler.GetUsersInLobby(int(lobby.ID))
	if userErr != nil {
		log.Printf("error getting users in session %d: %v", lobby.ID, userErr)
		return nil, status.Errorf(codes.PermissionDenied, "user is not in lobby")
	}

	//Change stack device
	_, dbErr := server.Store.UpdateStackUUID(context.Background(), db.UpdateStackUUIDParams{
		StackID: uuid.MustParse(req.UserUuid),
		ID:      lobby.ID,
	})
	if dbErr != nil {
		log.Printf("error changing stack device: %v", dbErr)
		return nil, status.Errorf(codes.Internal, "error changing stack device")
	}

	return &pb.Void{}, nil
}

//07542 4254 ZinsiBinsi Festnetz
//0160 91182690 Handy

func (server *Server) DisconnectLobby(ctx context.Context, req *pb.DisconnectLobbyRequest) (*pb.DisconnectLobbyResponse, error) {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	fmt.Printf("Disconnect from user %v in lobby %d", payload.UserID, req.LobbyId)

	server.LobbyHandler.RemoveStreamFromLobby(int(req.LobbyId), payload.UserID)

	return &pb.DisconnectLobbyResponse{Success: true}, nil
}

func (server *Server) StartGame(context context.Context, req *pb.StartGameRequest) (*pb.Void, error) {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	//Is token lobby owner
	dbLobby, getErr := server.Store.GetLobbyByOwnerUUID(context, payload.UserID)
	if getErr != nil {
		if getErr == sql.ErrNoRows {
			return nil, status.Errorf(codes.PermissionDenied, "user is not lobby owner")
		}
		log.Printf("error getting lobby: %v", getErr)
		return nil, status.Errorf(codes.Internal, "error getting lobby")
	}

	lobby, exists := server.LobbyHandler.LobbyStreams[int(dbLobby.ID)]
	if !exists {
		return nil, status.Errorf(codes.PermissionDenied, "user is not in lobby")
	}

	users, userErr := server.LobbyHandler.GetUsersInLobby(int(dbLobby.ID))
	if userErr != nil {
		log.Printf("error getting users in session %d: %v", dbLobby.ID, userErr)
		return nil, status.Errorf(codes.PermissionDenied, "user is not in lobby")
	}

	//Create Game
	gameId, createErr := server.GameHandler.CreateGame(lobby, dbLobby.ID)
	if createErr != nil {
		log.Printf("error creating game: %v", createErr)
		return nil, status.Errorf(codes.Internal, "error creating game")
	}

	server.LobbyHandler.SendMessageToLobby(int(dbLobby.ID), &pb.LobbyStatus{
		Users:      users,
		IsStarting: true,
		GameId:     int32(gameId),
		LobbyId:    int32(dbLobby.ID),
		MaxPlayers: dbLobby.MaxPlayers,
		IsDeleted:  false,
	})

	server.LobbyHandler.DeleteLobby(int(dbLobby.ID), false)

	return &pb.Void{}, nil
}
