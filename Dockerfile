FROM golang:1.13-alpine AS builder
RUN apk -U add git && \
    go get -v github.com/google/go-jsonnet/cmd/jsonnet

########
FROM alpine:latest
LABEL Author="s.nazir@syseleven.de" \
      Description="Simple Docker image to build configurations with go-jsonnet."

COPY --from=builder /go/bin/jsonnet /usr/local/bin/
COPY ./entrypoint.sh /
RUN chmod a+x /usr/local/bin/jsonnet /entrypoint.sh

VOLUME /src
WORKDIR /src

ENV BASEDIR=/src
ENTRYPOINT ["/entrypoint.sh"]
