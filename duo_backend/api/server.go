package api

import (
	"sync"

	"github.com/duo/pb"
	"github.com/duo/util"
)

type Server struct {
	pb.UnimplementedMessagingServiceServer
	Config           util.Config
	ConnectedClients map[string]pb.MessagingService_ConnectServer
	Mu               sync.Mutex
}

func NewServer(config util.Config) *Server {
	return &Server{
		Config:           config,
		ConnectedClients: make(map[string]pb.MessagingService_ConnectServer),
		Mu:               sync.Mutex{},
	}
}
