package api

import (
	"context"
	"database/sql"
	"log"

	"github.com/duo/pb"
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

	lobby, createErr := server.LobbyHandler.CreateLobby(payload.UserID, req.MaxPlayers)
	if createErr != nil {
		log.Printf("error creating session: %v", createErr)
		return status.Errorf(codes.Internal, "error creating session")
	}

	server.LobbyHandler.AddStreamToLobby(int(lobby.ID), *NewUserStream(stream, payload.UserID, payload.Username))
	return nil
}

func (server *Server) JoinLobby(req *pb.JoinLobbyRequest, stream pb.DUOService_JoinLobbyServer) error {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		return status.Errorf(codes.Unauthenticated, "invalid token")
	}

	lobby, getErr := server.Store.GetLobbyByID(context.Background(), req.SessionId)
	if getErr != nil {
		if getErr == sql.ErrNoRows {
			return status.Errorf(codes.NotFound, "session not found")
		}
		return status.Errorf(codes.Internal, "error getting session")
	}

	server.LobbyHandler.AddStreamToLobby(int(req.SessionId), *NewUserStream(stream, payload.UserID, payload.Username))

	users, usersErr := server.LobbyHandler.GetUsersInLobby(int(req.SessionId))
	if usersErr != nil {
		return status.Errorf(codes.Internal, "error getting users in session")
	}

	if int32(len(users)) >= lobby.MaxPlayers {
		return status.Errorf(codes.PermissionDenied, "session is full")
	}

	return nil
}

func (server *Server) DisconnectLobby(ctx context.Context, req *pb.DisconnectLobbyRequest) (*pb.DisconnectLobbyResponse, error) {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	server.LobbyHandler.RemoveStreamFromLobby(int(req.SessionId), payload.UserID)

	return &pb.DisconnectLobbyResponse{Success: true}, nil
}
