#!/bin/bash
echo "Create kubernetes-dashboard-certs, SSL using Openssl"
sudo mkdir certs
sudo chmod 777 -R certs
openssl req -nodes -newkey rsa:2048 -keyout certs/dashboard.key -out certs/dashboard.csr -subj "/C=/ST=/L=/O=/OU=/CN=kubernetes-dashboard"
openssl x509 -req -sha256 -days 365 -in certs/dashboard.csr -signkey certs/dashboard.key -out certs/dashboard.crt
sudo chmod -R 777 certs

#Install dashboard
echo "Installing dashboard"
kubectl apply -f admin-user.yaml
sleep 10s

#Install metric
echo "Installing metric"
kubeclt apply -f metric-install.yaml
sleep 5s
echo "Dashboard K8S install successfully"

#Print token
bash ./creat-token.sh

