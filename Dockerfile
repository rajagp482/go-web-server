#Dockerfile for compile and run the webserver.

FROM golang:alpine AS web
MAINTAINER RAJA

RUN apk --no-cache add gcc g++ make git
WORKDIR /go/src/app
COPY . .
RUN GOOS=linux go web -ldflags="-s -w" -o ./bin/web-app ./main.go

FROM alpine:3.9
RUN apk --no-cache add ca-certificates
WORKDIR /usr/bin
COPY --from=web /go/src/app/bin /go/bin
EXPOSE 8080
ENTRYPOINT /go/bin/web-app --port 8080
