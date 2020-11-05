FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash
RUN apk add mysql mysql-client
RUN rm -rf /var/cache/apk/*

COPY my.cnf /etc/mysql/my.cnf
COPY start.sh /start.sh

EXPOSE 3306

ENTRYPOINT sh /start.sh
