package api

import (
	"context"

	"github.com/duo/pb"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (server *Server) CreateSession(ctx context.Context, req *pb.CreateSessionRequest) (*pb.CreateSessionResponse, error) {
	payload, tokenErr := server.Maker.VerifyToken(req.Token)
	if tokenErr != nil {
		return nil, status.Errorf(codes.Unauthenticated, "invalid token")
	}

	session, createErr := server.SessionHandler.CreateSession(payload.UserID, req.Pin, server.Store)
	if createErr != nil {
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

	userStream := NewUserStream(stream, payload.UserID, payload.Username)

	server.SessionHandler.AddStreamToSession(int(req.SessionId), *userStream)

	return nil
}
