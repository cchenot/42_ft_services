#!/bin/sh

MYSQL_CMD="mysql -h $DB_HOST -u $DB_USER --password=$DB_PASSWORD"

if ! $MYSQL_CMD -e '' ; then
	echo Mysql connection error, cannot create Wordpress database
	exit 1
fi

if ! $MYSQL_CMD -e 'USE wordpress;' ; then
	echo creating wordpress database...
	$MYSQL_CMD -e 'CREATE DATABASE wordpress;' || ( $MYSQL_CMD -e 'DROP DATABASE wordpress;'; echo Creation error; exit 1)
#$MYSQL_CMD wordpress < /wordpress.sql || ($MYSQL_CMD -e 'DROP DATABASE wordpress;' echo wordpress.sql retrieval error; exit 1)
fi

if [ ! -d /var/www/nginx/wordpress/wp-admin ]; then
	cp -R /wordpress/* /var/www/wordpress
	cp /wp-config.php /var/www/wordpress
fi

php -S 0.0.0.0:5050 -t /var/www/wordpress
