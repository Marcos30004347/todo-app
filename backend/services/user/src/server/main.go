package main

import (
	"context"
	"log"
	"net"

	user "user-service/lib/protos/helloworld"

	"google.golang.org/grpc"
)

const (
	port = ":50051"
)

type server struct {
	user.UnimplementedGreeterServer
}

func (s *server) SayHello(ctx context.Context, in *user.HelloRequest) (*user.HelloReply, error) {
	log.Printf("Received: %v", in.GetName())
	return &user.HelloReply{Message: "Hello " + in.GetName()}, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	user.RegisterGreeterServer(s, &server{})
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}

// import (
//   "log"
//   "net"
//   "github.com/gin-gonic/gin"
//   "google.golang.org/grpc"
//   "user-service/chat"
// )

// func main() {
//   r := gin.Default()
//   r.GET("/ping", func(c *gin.Context) {
//     c.JSON(200, gin.H{
//             "message": "pong",
//     })
//   })

//   r.Run() // listen and serve on 0.0.0.0:8080

// 	lis, err := net.Listen("tcp", ":9000")
// 	if err != nil {
// 		log.Fatalf("failed to listen: %v", err)
// 	}

// 	grpcServer := grpc.NewServer()

// 	if err := grpcServer.Serve(lis); err != nil {
// 		log.Fatalf("failed to serve: %s", err)
// 	}
// }
