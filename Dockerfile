FROM golang:1.8-alpine
ADD . /go/src/hello-app
RUN apk add --no-cache git mercurial \
    && go get github.com/getsentry/sentry-go \
    && apk del git mercurial
RUN go install hello-app

FROM alpine:latest
COPY --from=0 /go/bin/hello-app .
ENV PORT 8080
CMD ["./hello-app"]
