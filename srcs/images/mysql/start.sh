#!/bin/sh

if [ ! -d /run/mysqld ]; then
	mkdir -p /run/mysqld
fi

if [ ! -d /app/mysql/mysql ]; then
	echo Initial data base was not created, creating now...
	mysql_install_db --user=root > /dev/null
	echo Initial database creation complete !
fi

tfile=`mktemp`
if [ ! -f "$tfile" ]; then
	echo Temp file creation error
	exit 1
fi

cat << EOF > $tfile
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO "$MYSQL_ROOT"@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
EOF

echo Bootstrapping mysqld...
if ! /usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile ; then
	echo Mysqld bootstrapping error...
	exit 1
fi

rm -f $tfile
echo Mysqld bootstrapping success !

echo Starting mysqld now !

exec /usr/bin/mysqld --user=root --console
