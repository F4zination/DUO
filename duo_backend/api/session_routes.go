package api

import (
	"context"
	"database/sql"
	"log"

	"github.com/duo/pb"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (server *Server) CreateSession(ctx context.Context, req *pb.CreateSessionRequest) (*pb.CreateSessionResponse, error) {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	_, getErr := server.Store.GetSessionByOwnerUUID(context.Background(), payload.UserID)
	if getErr != sql.ErrNoRows {
		return nil, status.Errorf(codes.AlreadyExists, "user already owns a session")
	}

	session, createErr := server.SessionHandler.CreateSession(payload.UserID, req.Pin, req.MaxPlayers)
	if createErr != nil {
		log.Printf("error creating session: %v", createErr)
		return nil, status.Errorf(codes.Internal, "error creating session")
	}

	return &pb.CreateSessionResponse{
		SessionId: session.ID,
		Pin:       session.Pin,
	}, nil
}

func (server *Server) JoinSession(req *pb.JoinSessionRequest, stream pb.DUOService_JoinSessionServer) error {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		return status.Errorf(codes.Unauthenticated, "invalid token")
	}

	dbSession, getErr := server.Store.GetSessionByID(context.Background(), req.SessionId)
	if getErr != nil {
		if getErr == sql.ErrNoRows {
			return status.Errorf(codes.NotFound, "session not found")
		}
		return status.Errorf(codes.Internal, "error getting session")
	}

	if dbSession.Pin != req.Pin {
		return status.Errorf(codes.PermissionDenied, "invalid pin")
	}

	users, usersErr := server.SessionHandler.GetUsersInSession(int(req.SessionId))
	if usersErr != nil {
		return status.Errorf(codes.Internal, "error getting users in session")
	}

	if int32(len(users)) >= dbSession.MaxPlayers {
		return status.Errorf(codes.PermissionDenied, "session is full")
	}

	userStream := NewUserStream(stream, payload.UserID, payload.Username)

	server.SessionHandler.AddStreamToSession(int(req.SessionId), *userStream)

	return nil
}

func (server *Server) DisconnectSession(ctx context.Context, req *pb.DisconnectSessionRequest) (*pb.DisconnectSessionResponse, error) {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	server.SessionHandler.RemoveStreamFromSession(int(req.SessionId), payload.UserID)

	return &pb.DisconnectSessionResponse{Success: true}, nil
}
