FROM ubuntu
RUN apt-get update
RUN apt-get -y install sudo -y
RUN apt-get install -my wget gnupg -y
RUN apt-get install lsb-release -y
RUN apt-get install git -y
RUN apt-get install openssl -y
RUN apt-get install curl -y
RUN apt-get install wget -y

RUN AZ_REPO=$(lsb_release -cs)
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list && \
    curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - && \
    apt-get install apt-transport-https && apt-get update && apt-get install azure-cli
RUN az aks install-cli


FROM centos
RUN yum update -y && yum upgrade -y
RUN yum install -y sudo unzip wget curl git openssl python3
RUN sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
RUN sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
RUN sudo yum install azure-cli -y

RUN az aks install-cli
RUN wget https://raw.githubusercontent.com/SpektraSystems/core-azure-launcher/master/deploy.sh
