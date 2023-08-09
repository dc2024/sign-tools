FROM golang:1.21.0-alpine3.18 AS builder

WORKDIR /src
COPY . .

RUN apk add --no-cache git && \
    go mod download && \
    CGO_ENABLED=0 go build -ldflags="-s -w" -buildvcs=false -o "SignTools"

FROM ubuntu:22.04

WORKDIR /

COPY --from=builder "/src/SignTools" "/"

ENTRYPOINT ["/SignTools"]
EXPOSE 8080
