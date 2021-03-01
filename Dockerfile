FROM golang:1.13-alpine AS builder
RUN apk -U add git && \
    go get -v github.com/google/go-jsonnet/cmd/jsonnet

########
FROM alpine:latest
LABEL Author="c.beneke@syseleven.de" \
      Description="Simple Docker image to build configurations with go-jsonnet."
RUN apk -U add git && \
    wget https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/v0.4.0/jb-linux-amd64 && \
    mv jb-linux-amd64 /usr/local/bin/jb

COPY --from=builder /go/bin/jsonnet /usr/local/bin/
COPY ./entrypoint.sh /
RUN chmod a+x /usr/local/bin/jb /usr/local/bin/jsonnet /entrypoint.sh

VOLUME /src
WORKDIR /src

ENV BASEDIR=/src
ENTRYPOINT ["/entrypoint.sh"]
