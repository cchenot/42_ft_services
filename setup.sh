#!/bin/sh

if ! which docker >/dev/null 2>&1 || ! which minikube >/dev/null 2>&1 ; then
	echo Please install Docker and Minikube
	exit 1
fi

#if minikube status >/dev/null 2>&1 ; then
#	echo Minikube already started, restarting to load needed settings
#	minikube delete
#fi

minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000
minikube addons enable ingress
minikube addons enable dashboard

MINIKUBE_IP=$(minikube ip)

eval $(minikube docker-env)

#replacing MINIKUBE_IP where needed

cp ./srcs/images/ftps/start.sh ./srcs/images/ftps/start-tmp.sh
sed -i '' "s/#MINIKUBE_IP#/$MINIKUBE_IP/g" ./srcs/images/ftps/start-tmp.sh
cp ./srcs/images/wordpress/wordpress.sql ./srcs/images/wordpress/wordpress-tmp.sql
sed -i '' "s/#MINIKUBE_IP#/$MINIKUBE_IP/g" ./srcs/images/wordpress/wordpress-tmp.sql
sed -i '' "s/#MINIKUBE_IP#/$MINIKUBE_IP/g" ./srcs/yaml/my-telegraf.yaml

echo "UPDATE data_source SET url = 'http://$MINIKUBE_IP:8086'" | sqlite3 ./srcs/images/grafana/grafana.db

#building docker images

docker build -t my-nginx ./srcs/images/nginx
docker build -t my-mysql ./srcs/images/mysql
docker build -t my-wordpress ./srcs/images/wordpress
docker build -t my-ftps ./srcs/images/ftps
docker build -t my-phpmyadmin ./srcs/images/phpmyadmin
docker build -t my-influxdb ./srcs/images/influxdb
docker build -t my-telegraf ./srcs/images/telegraf
docker build -t my-grafana ./srcs/images/grafana

kubectl apply -k ./srcs/yaml/

rm -rf ./srcs/images/ftps/start-tmp.sh
rm -rf ./srcs/images/wordpress/wordpress-tmp.sql

sed -i '' "s/$MINIKUBE_IP/#MINIKUBE_IP#/g" ./srcs/yaml/my-telegraf.yaml
echo ft-services deployed, please wait for the pods to be running
echo you can access ft_services through http://$MINIKUBE_IP
