package api

import (
	"context"
	"log"

	"github.com/duo/pb"
	"github.com/google/uuid"
)

func (server *Server) Connect(empty *pb.Empty, stream pb.MessagingService_ConnectServer) error {
	log.Printf("Client connected")
	clientID := uuid.New().String()

	server.Mu.Lock()
	server.ConnectedClients[clientID] = stream
	server.Mu.Unlock()

	//Wait for client to disconnect
	<-stream.Context().Done()

	log.Printf("Client disconnected")
	server.Mu.Lock()
	delete(server.ConnectedClients, clientID)
	server.Mu.Unlock()

	return nil
}

func (server *Server) Send(context context.Context, request *pb.Request) (*pb.Empty, error) {
	server.Mu.Lock()
	defer server.Mu.Unlock()

	log.Printf("Sending message to %d clients", len(server.ConnectedClients))
	for clientID, stream := range server.ConnectedClients {
		if err := stream.Send(request); err != nil {
			log.Printf("Error sending message to client %s: %v", clientID, err)
			return nil, err
		}
	}
	return &pb.Empty{}, nil
}
