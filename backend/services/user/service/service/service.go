package service

import (
	"user/database"
	"user/network"
)

func Run() {
	// Connect to the database
	database.InitDatabase("mongodb://userdb:27017")

	// Init network services (REST, GRPC)
	network.InitNetword(30051, 30052)
	network.Run()
}
