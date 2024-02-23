package api

import (
	"context"
	"log"

	"github.com/duo/pb"
)

func (server *Server) Connect(empty *pb.Empty, stream pb.MessagingService_ConnectServer) error {
	log.Printf("Client connected")
	i := 0
	err := stream.Send(&pb.Request{Name: "Hello"})
	if err != nil {
		return err
	}
	log.Printf("Sent message %d", i)
	i++
	return nil
}

func (server *Server) Send(context context.Context, request *pb.Request) (*pb.Empty, error) {
	return &pb.Empty{}, nil
}
