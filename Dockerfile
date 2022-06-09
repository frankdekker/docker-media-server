FROM alpine:latest

LABEL maintainer="Frank Dekker <fdekker@123inkt.nl>"

RUN apk upgrade --update-cache --available && \
    apk add openssl && \
    rm -rf /var/cache/apk/*
