FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash && apk add influxdb

COPY /start.sh /start.sh

RUN chmod +x start.sh

EXPOSE 8086

ENTRYPOINT sh ./start.sh
