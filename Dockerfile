FROM microsoft/azure-cli

RUN apt-get update
RUN apt-get install -y git
RUN apt-get -y install curl
RUN apt-get -y install openssl
RUN az aks install-cli