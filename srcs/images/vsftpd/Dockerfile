FROM alpine:latest

RUN apk add --no-cache --upgrade bash
RUN apk add --no-cache vsftpd openssl vim openrc

COPY /vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY /start.sh /start.sh

EXPOSE 20 21

ENTRYPOINT sh /start.sh
