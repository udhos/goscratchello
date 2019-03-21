# STEP 1 build executable binary

#FROM golang:alpine as builder
FROM golang:1.12.1-alpine as builder

# Create appuser on builder image
RUN adduser -D -g '' appuser

COPY app/* $GOPATH/src/app/
WORKDIR $GOPATH/src/app/

#get dependancies
RUN go get -d -v

#build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /go/bin/app

# STEP 2 build a small image

# start from scratch
FROM scratch

# copy appuser from builder image
COPY --from=builder /etc/passwd /etc/passwd

# Copy our static executable
COPY --from=builder /go/bin/app /go/bin/app

USER appuser

ENTRYPOINT ["/go/bin/app"]
