# core-azure-launcher


## Pre-Requisite
 - Azure Subscription
 - SPN Details: See this for more information on setting up SPN for AKS: https://docs.microsoft.com/en-us/azure/container-service/kubernetes/container-service-kubernetes-service-principal

 
 
 ## Deploy
 
 - Click on Deploy to Azure Button

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FSpektraSystems%2Fcore-azure-launcher%2Fmaster%2FACI%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

- Enter all parameter values and CLick Purchase

## Post Deployment
Post Sucessful deployment
- Connect to AKS Cluster via CloudShell or AZ CLI. See this for more information: https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough#connect-to-the-cluster

az aks get-credentials --resource-group myAKSCluster --name myAKSCluster

- Verify deployments by ensure cjoc-0 pod is running. If status is creating etc, you should wait for about 2 minutes for completion

kubectl get pods

- Run following command to find admin password of jenkins instance

kubectl exec cjoc-0 -- cat /var/jenkins_home/secrets/initialAdminPassword

- Run following command to find DNS name of CJOC.

 kubectl get ingress


You can now use CJOC for further deployment and operations. See Administering CloudBees Jenkins Enterprise for further information.https://go.cloudbees.com/docs/cloudbees-documentation/cje-v2-admin-guide/


 
