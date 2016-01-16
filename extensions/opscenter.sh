#!/bin/bash

echo "Installing Java"
add-apt-repository -y ppa:webupd8team/java
apt-get -y update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get -y install oracle-java8-installer

echo "Installing OpsCenter"
echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/datastax.community.list
curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
apt-get update
apt-get -y install opscenter=5.2.3

# By default OpsCenter will use the private IP for a variety of interfaces.  The ndoes won't be able to resolve this.
DNSNAME=$3'.westus.cloudapp.azure.com'
IP=$DNSNAME

echo '[agents]' >> /etc/opscenter/opscenterd.conf
echo 'reported_interface='$IP >> /etc/opscenter/opscenterd.conf
echo 'incoming_interface='$IP >> /etc/opscenter/opscenterd.conf

echo "Starting OpsCenter"
sudo service opscenterd start

wget https://raw.githubusercontent.com/J4U-Nimbus/EMJU_DataStaxARM/master/extensions/opscenter.py

echo "Generating a provision.json file"
python opscenter.py $1 $2 $3

echo "Provisioning a new cluster using provision.json"
curl --insecure -H "Accept: application/json" -X POST http://127.0.0.1:8888/provision -d @provision.json
