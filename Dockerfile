FROM golang:alpine as builder

WORKDIR /go/src/app
COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" fcd-rocks.go

FROM scratch

WORKDIR /go/src/app

COPY --from=builder /go/src/app/fcd-rocks /usr/bin/

ENTRYPOINT ["fcd-rocks"]
