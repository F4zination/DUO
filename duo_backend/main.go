package main

import (
	"database/sql"
	"fmt"
	"log"
	"net"

	"github.com/duo/api"
	db "github.com/duo/db/sqlc"
	"github.com/duo/pb"
	"github.com/duo/util"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"

	_ "github.com/lib/pq" // postgres driver
)

func main() {
	config, configErr := util.LoadConfig(".")
	if configErr != nil {
		fmt.Println(configErr)
		return
	}

	dbConn, dbErr := sql.Open(config.DBDriver, config.DBSource)
	if dbErr != nil {
		log.Fatalf("Error connecting to db: %s", dbErr)
		return
	}
	store := db.NewStore(dbConn)

	RunGrpcServer(store, config)
}

func RunGrpcServer(store db.Store, config util.Config) {
	server := api.NewServer(store, config)
	gRPCServer := grpc.NewServer()

	pb.RegisterDUOServiceServer(gRPCServer, server)
	reflection.Register(gRPCServer)

	listener, err := net.Listen("tcp", config.ServerAddress)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	log.Printf("Starting server at %s", listener.Addr().String())
	err = gRPCServer.Serve(listener)
	if err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
