package main

import (
	"net/http"
	"time"

	"github.com/gorilla/mux"
	server "github.com/naosuke884/hey-you"
	"github.com/naosuke884/hey-you/handler"
	"github.com/rs/zerolog/log"
)

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/", handler.HomeHandler)
	http.Handle("/", router)

	srver := &http.Server{
		Handler:      router,
		Addr:         server.Envs.Address,
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}
	log.Info().Str("address", server.Envs.Address).Msg("server start")
	log.Fatal().Err(srver.ListenAndServe()).Msg("server stop")
}
