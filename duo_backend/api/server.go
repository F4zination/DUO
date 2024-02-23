package api

import (
	"github.com/duo/pb"
	"github.com/duo/util"
)

type Server struct {
	pb.UnimplementedMessagingServiceServer
	config util.Config
}

func NewServer(config util.Config) *Server {
	return &Server{
		config: config,
	}
}
