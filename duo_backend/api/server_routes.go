package api

import (
	"context"
	"log"
	"time"

	"github.com/duo/pb"
)

func (server *Server) Connect(empty *pb.Empty, stream pb.MessagingService_ConnectServer) error {
	log.Printf("Client connected")
	go func() {
		i := 0
		for {
			err := stream.Send(&pb.Request{Name: string(rune(i))})
			if err != nil {
				return
			}
			log.Printf("Sent message %d", i)
			i++
			time.Sleep(1 * time.Second)
		}
	}()
	return nil
}

func (server *Server) Send(context context.Context, request *pb.Request) (*pb.Empty, error) {
	return &pb.Empty{}, nil
}
