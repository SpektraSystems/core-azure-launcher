FROM centos
RUN yum update -y && yum upgrade -y
RUN yum install -y sudo unzip wget curl git openssl python3
RUN sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
RUN sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
RUN sudo yum install azure-cli -y
RUN export PATH=~/tmp/cje:$PATH

RUN az aks install-cli
RUN mkdir /tmp/cje
RUN wget https://raw.githubusercontent.com/SpektraSystems/core-azure-launcher/master/ACI/bootstrap.sh
RUN chmod +x bootstrap.sh
RUN cp bootstrap.sh /tmp/cje/bootstrap.sh
RUN chmod +x bootstrap.sh
ENTRYPOINT ["./bootstrap.sh"]
