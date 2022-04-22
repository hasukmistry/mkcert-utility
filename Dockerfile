FROM golang:alpine

LABEL maintainer="Hasmukh Mistry"

RUN apk --no-cache add nss-tools git

WORKDIR /mkcert

RUN git clone https://github.com/FiloSottile/mkcert .

RUN go build -ldflags "-X main.Version=$(git describe --tags)"

RUN mv mkcert /usr/local/bin/mkcert