FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash
RUN apk add wget vim

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.1-static_linux_amd64.tar.gz
RUN tar -C . -xzf telegraf-1.14.1-static_linux_amd64.tar.gz
RUN chmod +x telegraf/*
RUN cp telegraf/telegraf /usr/bin/
RUN rm -rf /var/cache/apk/*

RUN mkdir -p /etc/telegraf
COPY telegraf.conf /etc/telegraf/telegraf.conf
COPY start.sh /start.sh

EXPOSE 8125

ENTRYPOINT sh ./start.sh
