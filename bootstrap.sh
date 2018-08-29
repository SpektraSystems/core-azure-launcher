#!/bin/bash
#
# Copyright 2018 Spektra Systems LLC


#!/bin/sh
cjedns="cjoc"
#rbacenabled="$7"

function deploy_ingress
{
    echo $cfg | base64 --decode > config.txt
    export KUBECONFIG=config.txt
    kubectl apply -f https://raw.githubusercontent.com/SpektraSystems/core-azure-launcher/master/manifest/ingress-mandatory.yaml
    kubectl apply -f https://raw.githubusercontent.com/SpektraSystems/core-azure-launcher/master/manifest/ingress-cloud-generic.yaml
 while [[ "$(kubectl get svc ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" = '' ]]; do sleep 3; done
    INGRESS_IP=$(kubectl get svc ingress-nginx  -o jsonpath='{.status.loadBalancer.ingress[0].ip}' | sed 's/"//g')
    echo "NGINX INGRESS: $INGRESS_IP"
    DOMAIN_NAME="$INGRESS_IP.xip.io"
    HOSTNAME=`echo $DOMAIN_NAME | sed "s/\"//g"`
    CJEHOSTNAME="$cjedns.$HOSTNAME"
}

#create self-signed cert
function create_cert
{
  wget https://raw.githubusercontent.com/SpektraSystems/core-azure-launcher/master/manifest/server.config
  sed -i -e "s#cje.example.com#$CJEHOSTNAME#" "server.config"

  openssl req -config server.config -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr

  echo "Created server.key"
  echo "Created server.csr"

  openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
  echo "Created server.crt (self-signed)"

  kubectl create secret tls cjoc-tls --cert=server.crt --key=server.key
}


function deploy_cje
{
wget https://raw.githubusercontent.com/SpektraSystems/core-azure-launcher/master/manifest/cje.yml
sed -i -e "s#cje.example.com#$CJEHOSTNAME#" "cje.yml"
kubectl apply -f cje.yml
kubectl rollout status sts cjoc
}


deploy_ingress
create_cert
deploy_cje

