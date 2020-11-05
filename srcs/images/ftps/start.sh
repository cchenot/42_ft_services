#!/bin/sh

if [ ! -d /ftps/${FTP_USER} ]; then
	mkdir -p /ftps/${FTP_USER}
fi

if [ ! -f /etc/ssl/private/pure-ftpd.pem ]; then
	openssl req -nodes -x509 -subj '/CN=localhost' -newkey rsa:4096 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -days 365
	chmod 600 /etc/ssl/private/pure-ftpd.pem
fi

#if [ ! id -u ${FTP_USER} > /dev/null 2>&1 ]; then
	adduser -h /ftps/${FTP_USER} -D ${FTP_USER}
#fi
	echo "ftpuser:pwdftp" | chpasswd

/usr/sbin/pure-ftpd -j -Y 2 -p 30021:30021 -P "#MINIKUBE_IP#"
