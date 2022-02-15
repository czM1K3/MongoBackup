FROM golang:1.17-alpine as build
WORKDIR /app
COPY go.mod main.go ./
RUN go build -o ./backup .

FROM alpine

RUN apk add --no-cache mongodb-tools ca-certificates
RUN rm -rf /var/cache/apk/*

COPY --from=build /app/backup /mongo-backup

ENTRYPOINT ["/mongo-backup"]
