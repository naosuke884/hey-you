FROM node:23-bullseye AS node-build
COPY client /work/client/

# temporary workaround for build error
WORKDIR /work/client/build

FROM golang:1.24.0-bullseye AS go-build
COPY server /work/server/
COPY --from=node-build /work/client/build /work/client
WORKDIR /work/server
RUN go mod download
RUN CGO_ENABLE=0 go build -trimpath -ldflags='-s -w' -o main ./cmd/serve/main.go
RUN chmod +x main

FROM ubuntu:24.04 AS production
WORKDIR /work/
COPY --from=build /work/server/main ./server/main
USER ubuntu
CMD ["./server/main"]