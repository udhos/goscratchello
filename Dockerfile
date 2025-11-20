# STEP 1 build executable binary

#FROM golang:alpine as builder
FROM golang:1.25.4-alpine AS builder

# Create appuser on builder image
RUN adduser -D -g '' appuser

COPY app/* /build/app/
COPY go.mod /build/

WORKDIR /build

#build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags='-s -w' -trimpath -o /app ./app

# STEP 2 build a small image

# start from scratch
FROM scratch

# copy appuser from builder image
COPY --from=builder /etc/passwd /etc/passwd

# Copy our static executable
COPY --from=builder /app /app

USER appuser

ENTRYPOINT ["/app"]
