FROM golang:1.26-alpine AS builder

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o app .

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/app .

COPY --from=builder /app/tracker.db .

CMD ["./app"]