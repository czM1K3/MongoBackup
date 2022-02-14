FROM golang:1.17-stretch as build
WORKDIR /app
COPY go.mod main.go ./
RUN go build -o ./backup .

FROM ubuntu:20.04
RUN apt update && apt upgrade -y
ADD https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2004-x86_64-100.5.2.deb /mongodb-database-tools.deb
RUN apt install -y /mongodb-database-tools.deb ca-certificates
RUN rm mongodb-database-tools.deb

RUN apt clean

COPY --from=build /app/backup /mongo-backup

ENTRYPOINT ["/mongo-backup"]
