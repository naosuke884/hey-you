FROM ubuntu:24.04 AS build
ENV SHELL=bash
ENV PATH=/usr/local/node-v20.18.0-linux-x64/bin:$PATH
RUN apt update && apt install -y \
  curl \
  xz-utils \
  golang 
RUN curl -O https://nodejs.org/dist/v20.18.0/node-v20.18.0-linux-x64.tar.xz \
  && tar -xvf node-v20.18.0-linux-x64.tar.xz -C /usr/local/ \
  && rm node-v20.18.0-linux-x64.tar.xz \
  && curl -fsSL https://get.pnpm.io/install.sh | sh -
WORKDIR /work/
COPY ./server .
WORKDIR /work/server
RUN go mod download
RUN CGO_ENABLE=0 go build -trimpath -ldflags='-s -w' -o main
RUN chmod +x main

FROM ubuntu:24.04 AS production
WORKDIR /work/
COPY --from=build /work/server/main ./server/main
USER ubuntu
CMD ["./server/main"]