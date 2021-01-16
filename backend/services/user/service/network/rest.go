package network

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

type RESTServer struct {
	server *http.Server
}

func ping(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "pong",
	})
}

func router01() http.Handler {
	e := gin.New()
	e.Use(gin.Recovery())
	e.GET("/", ping)

	return e
}

func (serv *RESTServer) Run() error {
	serv.server = &http.Server{
		Addr:         ":8080",
		Handler:      router01(),
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
	}

	return serv.server.ListenAndServe()

}

func InitRESTServer() *RESTServer {
	rest := &RESTServer{}
	rest.Run()
	return rest
}
