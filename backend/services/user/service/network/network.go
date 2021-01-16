package network

import (
	"log"

	"golang.org/x/sync/errgroup"
)

var (
	g errgroup.Group
)

type Network struct {
	grpc *GRPCServer
	rest *RESTServer
}

func (net *Network) run() error {
	net.grpc = InitGRPCServer()
	net.rest = InitRESTServer()

	return nil
}

func InitNetword() *Network {
	net := &Network{nil, nil}
	err := net.run()

	if err != nil {
		log.Fatalf("failed to serve: %v", err)
		panic(1)
	}
	return net
}

func (net *Network) Run() {
	g.Go(func() error {
		return net.rest.Run()
	})

	g.Go(func() error {
		return net.grpc.Run()
	})

	err := g.Wait()

	if err != nil {
		log.Fatal(err)
		panic(1)
	}
}
