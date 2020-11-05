FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash

RUN apk add openssl openssh && apk add nginx && mkdir -p /run/nginx
RUN adduser -D -g 'www' www
RUN mkdir -p /var/www/nginx
RUN chown -R www:www /var/lib/nginx && chown -R www:www /var/www/nginx
RUN rm -rf /var/cache/apk/*

RUN	openssl req -nodes -x509 -subj '/CN=localhost' -newkey rsa:4096 -keyout /etc/ssl/key.pem -out /etc/ssl/cert.pem -days 365;

COPY /nginx.conf /etc/nginx/nginx.conf
COPY /index.html /var/www/nginx/
COPY /start.sh /start.sh
COPY /ssh_host_dsa_key /etc/ssh
COPY /ssh_host_rsa_key /etc/ssh
COPY /sshd_config /etc/ssh

RUN chmod 600 /etc/ssh/ssh_host_rsa_key
RUN chmod +x start.sh

EXPOSE 80 443 30022

ENTRYPOINT sh /start.sh
