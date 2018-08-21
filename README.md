# core-azure-launcher


## Pre-Requisite
 - Azure Subscription with Containers and Terraform RP enabled and registered
 - SPN Details: See this for more information on setting up SPN for AKS: https://docs.microsoft.com/en-us/azure/container-service/kubernetes/container-service-kubernetes-service-principal
 - SSH Public Key for Linux Agent Nodes
 
 
 ## Deploy
 
 - Click on Deploy to Azure Button

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FSpektraSystems%2Fcore-azure-launcher%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

- Enter all parameter values and CLick Purchase

## Post Deployment
Post Sucessful deployment
- Connect to AKS Cluster via CloudShell or AZ CLI. See this for more information: https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough#connect-to-the-cluster

- Run following command to find admin password of jenkins instance

kubectl exec cjoc-0 -- cat /var/jenkins_home/secrets/initialAdminPassword

- Run following command to find DNS name of CJOC.

 kubectl get ingress


You can now use CJOC for further deployment and operations.
 
