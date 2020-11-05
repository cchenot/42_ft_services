#!/bin/sh

if [ ! -d /home/${FTP_USER} ]; then
	mkdir -p /home/${FTP_USER}
fi

if ! id -u ${FTP_USER} > /dev/null 2>&1; then
	adduser -h /home/${FTP_USER} -s /bin/false -D ${FTP_USER} ${FTP_USER}
fi

echo "${FTP_USER}:${FTP_PASSWORD}" | /usr/sbin/chpasswd

chown -R ${FTP_USER}:${FTP_USER} /home/${FTP_USER}

if [ ! -f /etc/ssl/vsfptdkey.pem ]; then
	openssl req -nodes -x509 -subj '/CN=localhost' -newkey rsa:4096 -keyout /etc/ssl/vsfptdkey.pem -out /etc/ssl/vsftpdcert.pem -days 365;
fi

sleep infinity & wait
#/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
