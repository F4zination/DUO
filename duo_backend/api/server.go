package api

import (
	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/duo/util"
)

type Server struct {
	pb.UnimplementedMessagingServiceServer
	Config util.Config
	Store  db.Store
}

func NewServer(store db.Store, config util.Config) *Server {
	return &Server{
		Store:  store,
		Config: config,
	}
}
