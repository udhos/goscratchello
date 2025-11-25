# STEP 1 build executable binary

FROM golang:1.25.4-alpine AS builder

RUN adduser -D -g '' appuser
COPY app/* /build/app/
COPY go.mod /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags='-s -w' -trimpath -o /app ./app
RUN wget https://github.com/upx/upx/releases/download/v5.0.2/upx-5.0.2-amd64_linux.tar.xz
RUN tar xf upx-5.0.2-amd64_linux.tar.xz
RUN ./upx-5.0.2-amd64_linux/upx -9 /app

# STEP 2 build a small image

FROM scratch

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /app /app
USER appuser
ENTRYPOINT ["/app"]
