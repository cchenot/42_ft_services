FROM alpine:latest

RUN apk add --no-cache --upgrade bash
RUN apk add vim && apk upgrade
RUN printf '%s\n' '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' \
>> /etc/apk/repositories
RUN apk update && apk add openssl && apk add pure-ftpd@testing="1.0.49-r1"
RUN rm -rf /var/cache/apk/*

COPY /start-tmp.sh /start.sh

EXPOSE 21 30021

ENTRYPOINT sh /start.sh
