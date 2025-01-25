package main

import (
	"log"
	"net/http"
	"time"

	"github.com/gorilla/mux"
	"github.com/naosuke884/hey-you/handler"
)

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/", handler.HomeHandler)
	http.Handle("/", router)

	srver := &http.Server{
		Handler:      router,
		Addr:         "127.0.0.1:8080",
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}
	log.Fatal(srver.ListenAndServe())
}
