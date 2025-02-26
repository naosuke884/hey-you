FROM node:23-bullseye AS node-build
COPY client /work/client/

FROM golang:1.x-bullseye AS go-build
# ENV SHELL=bash
# ENV PATH=/usr/local/node-v20.18.0-linux-x64/bin:$PATH
# RUN apt update && apt install -y \
#   curl \
#   xz-utils \
#   golang 
# RUN curl -O https://nodejs.org/dist/v20.18.0/node-v20.18.0-linux-x64.tar.xz \
#   && tar -xvf node-v20.18.0-linux-x64.tar.xz -C /usr/local/ \
#   && rm node-v20.18.0-linux-x64.tar.xz \
#   && curl -fsSL https://get.pnpm.io/install.sh | sh -
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