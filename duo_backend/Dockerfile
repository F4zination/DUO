FROM golang AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /duo_backend .

FROM alpine

COPY --from=builder /app/app.env /app.env

COPY --from=builder /duo_backend /duo_backend

CMD ["/duo_backend"]

EXPOSE 8080

