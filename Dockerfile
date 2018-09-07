FROM golang:1.11-alpine AS builder
RUN apk -U add git && \
    go get -v github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb && \
    go get -v github.com/google/go-jsonnet/jsonnet

########
FROM alpine:latest
LABEL Author="c.beneke@syseleven.de" \
      Description="Simple Docker image to build configurations with go-jsonnet."
RUN apk -U add git

COPY --from=builder /go/bin/jb /usr/local/bin/
COPY --from=builder /go/bin/jsonnet /usr/local/bin/
COPY ./entrypoint.sh /
RUN chmod a+x /usr/local/bin/jb /usr/local/bin/jsonnet /entrypoint.sh

VOLUME /src
WORKDIR /src

ENV BASEDIR=/src
ENTRYPOINT ["/entrypoint.sh"]
