#!/bin/bash
#Deploy dashboard
echo "Deployment dashboard-v2.7.0"
kubectl apply -f dashboard-v2.7.0.yaml
sleep 5

#Create cert using openssl
echo "Create kubernetes-dashboard-certs, SSL using Openssl"
sudo mkdir certs
sudo chmod 777 -R certs
openssl req -nodes -newkey rsa:2048 -keyout certs/dashboard.key -out certs/dashboard.csr -subj "/C=/ST=/L=/O=/OU=/CN=kubernetes-dashboard"
openssl x509 -req -sha256 -days 365 -in certs/dashboard.csr -signkey certs/dashboard.key -out certs/dashboard.crt
sudo chmod -R 777 certs
kubectl create secret generic kubernetes-dashboard-certs --from-file=certs -n kubernetes-dashboard
sleep 5

kubectl apply -f admin-user.yaml
sleep 5s

#Install metric
echo "Installing metric"
kubectl apply -f metric-install.yaml
sleep 5s
echo "Dashboard K8S install successfully"

#Print token
bash ./creat-token.sh

