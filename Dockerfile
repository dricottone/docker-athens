# Athens Dockerfile
# Dominic Ricottone
# BSD 3-Clause
# Significant credit due to the upstream team at https://github.com/dricottone/athens

ARG GOLANG_VERSION=1.14-alpine
ARG ALPINE_VERSION=3.11

FROM arm64v8/golang:${GOLANG_VERSION} AS builder

WORKDIR $GOPATH/src/github.com/gomods/athens

ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOPROXY="https://proxy.golang.org"

COPY build/athens-main .

RUN DATE="$(date -u +%Y-%m-%d-%H:%M:%S-%Z)" go build -ldflags "-X github.com/gomods/athens/pkg/build.version=$VERSION -X github.com/gomods/athens/pkg/build.buildDate=$DATE" -o /bin/athens-proxy ./cmd/proxy

FROM alpine:${ALPINE_VERSION}

ENV GO111MODULE=on

COPY --from=builder /bin/athens-proxy /bin/athens-proxy
COPY --from=builder /go/src/github.com/gomods/athens/config.dev.toml /config/athens.toml
COPY --from=builder /usr/local/go/bin/go /bin/go

RUN chmod 700 /config/athens.toml

RUN apk add --update bzr git git-lfs mercurial openssh-client subversion procps fossil dumb-init
RUN mkdir -p /usr/local/go

EXPOSE 3000

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["athens-proxy", "-config_file", "/config/athens.toml"]

