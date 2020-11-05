FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash
RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat

RUN wget https://dl.grafana.com/oss/release/grafana-6.7.2.linux-amd64.tar.gz
RUN tar -xvf grafana-6.7.2.linux-amd64.tar.gz

RUN rm /grafana-6.7.2/conf/defaults.ini

COPY ./defaults.ini ./grafana-6.7.2/conf/defaults.ini
COPY ./grafana.db ./grafana-6.7.2/data/

COPY start.sh start.sh

RUN chmod +x ./start.sh

EXPOSE 3000

ENTRYPOINT sh ./start.sh
