package api

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/duo/pb"
)

func (server *Server) Connect(empty *pb.Empty, stream pb.MessagingService_ConnectServer) error {
	log.Printf("Client connected")
	reqChan := make(chan *pb.Request)
	go func() {
		i := 0
		for {
			log.Printf("Sending request %d", i)
			reqChan <- &pb.Request{Name: fmt.Sprintf("Num: %d", i)}
			i++
			time.Sleep(1 * time.Second)
		}
	}()
	for {
		select {
		case req := <-reqChan:
			err := stream.Send(req)
			if err != nil {
				return err
			}
		case <-stream.Context().Done():
			log.Printf("Client disconnected")
			return nil
		}
	}
}

func (server *Server) Send(context context.Context, request *pb.Request) (*pb.Empty, error) {
	return &pb.Empty{}, nil
}
