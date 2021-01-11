package main

import (
  "log"
  "net"
  "github.com/gin-gonic/gin"
  "google.golang.org/grpc"
  "user-service/chat"
)

func main() {
  r := gin.Default()
  r.GET("/ping", func(c *gin.Context) {
    c.JSON(200, gin.H{
            "message": "pong",
    })
  })

  r.Run() // listen and serve on 0.0.0.0:8080

	lis, err := net.Listen("tcp", ":9000")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	grpcServer := grpc.NewServer()

	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %s", err)
	}
}
