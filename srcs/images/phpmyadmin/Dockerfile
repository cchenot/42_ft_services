FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash
RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-json php7-session php7-mbstring
RUN apk add wget mysql mysql-client

RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-all-languages.tar.gz && tar -xvf phpMyAdmin-4.9.5-all-languages.tar.gz

RUN mkdir -p /var/www/phpmyadmin
RUN cp -R /phpMyAdmin-4.9.5-all-languages/* /var/www/phpmyadmin

RUN rm -rf /var/cache/apk/*

COPY /config.inc.php /var/www/phpmyadmin
COPY /start.sh /start.sh

RUN chmod +x start.sh

EXPOSE 5000

ENTRYPOINT sh /start.sh
