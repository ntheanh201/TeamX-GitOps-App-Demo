FROM golang:1.19.4-alpine3.16 AS build-env

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
        go build -tags migrate -o /bin/app

FROM scratch
COPY --from=build-env /bin/app /app

EXPOSE 8080
CMD ["/app"]
