package network

import (
	"context"
	"log"
	"net"

	"user/codegen/pb/user/v1"

	"google.golang.org/grpc"
)

const port = ":50051"

type GreaterHandler struct {
	user.UnimplementedUserServer
}

func (s *GreaterHandler) SayHello(ctx context.Context, in *user.HelloRequest) (*user.HelloReply, error) {
	log.Printf("Received: %v", in.GetName())
	return &user.HelloReply{Message: "Hello " + in.GetName()}, nil
}

type GRPCServer struct {
	listener net.Listener
	server   *grpc.Server
}

func (server *GRPCServer) Run() error {
	lis, err := net.Listen("tcp", port)

	server.listener = lis

	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	server.server = grpc.NewServer()

	user.RegisterUserServer(server.server, &GreaterHandler{})

	if err := server.server.Serve(server.listener); err != nil {
		return err
	}

	return nil
}

func InitGRPCServer() *GRPCServer {
	grpc := &GRPCServer{}
	return grpc
}
