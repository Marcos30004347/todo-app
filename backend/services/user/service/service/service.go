package service

import "user/network"

func Run() {
	net := network.InitNetword()
	defer net.Run()
}
