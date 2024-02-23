package main

import (
	"fmt"
	"log"
	"net"

	"github.com/duo/api"
	"github.com/duo/pb"
	"github.com/duo/util"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	config, configErr := util.LoadConfig(".")
	if configErr != nil {
		fmt.Println(configErr)
		return
	}

	RunGrpcServer(config)
}

func RunGrpcServer(config util.Config) {
	server := api.NewServer(config)
	gRPCServer := grpc.NewServer()

	pb.RegisterMessagingServiceServer(gRPCServer, server)
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
