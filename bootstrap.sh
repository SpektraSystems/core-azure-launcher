#!/bin/bash
#
# Copyright 2018 Spektra Systems LLC


#!/bin/sh
## Argument 1 will be  SPN App ID
## Argument 2 will be password for SPN App 
## Argument 3 will be Tenant ID
## Argument 4 will be resource group name
## Argument 5 will be AKS Cluster Name
## Argument 6 will be CJOC DNS Initial

spnappid="$1"
spnapppassword="$2"
spntenantid="$3"
rgname="$4"
k8name="$5"
cjedns="$6"


function prep_deployment
{
    az login --service-principal -u $spnappid -p $spnapppassword --tenant $spntenantid
    az aks get-credentials -g $rgname -n $k8name
    DOMAIN_NAME=`az aks show --resource-group $rgname --name $k8name --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName`
    HOSTNAME=`echo $DOMAIN_NAME | sed "s/\"//g"`
    CJEHOSTNAME="$cjedns.$HOSTNAME"

}
function deploy_cje
{
wget https://raw.githubusercontent.com/SpektraSystems/core-azure-launcher/master/cje.yml
sed -i -e "s#cje.example.com#$CJEHOSTNAME#" "cje.yml"
kubectl apply -f cje.yml
kubectl rollout status sts cjoc
}

function clean_up
{
kubectl delete pods corebootstrap
}

prep_deployment
deploy_cje
sleep 120
clean_up
