#!/bin/bash

echo "Installing Azul Zulu JDK"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
apt-add-repository -y "deb http://repos.azulsystems.com/ubuntu stable main"
apt-get -y update
apt-get -y install zulu-8

echo "Installing OpsCenter"
echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/datastax.community.list
curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
apt-get update
apt-get -y install opscenter=5.2.3

# By default OpsCenter will use the private IP for a variety of interfaces.  The ndoes won't be able to resolve this.
echo "Trying to determine my IP address."
DNSNAME='opsc'$3'.westus.cloudapp.azure.com'
echo "My DNS name is $DNSNAME."
IP=`getent hosts $DNSNAME | awk '{ print $1 }'`
echo "My IP address is $IP."

echo "Making changes to the OpsCenter config based on my IP."
echo '[agents]' >> /etc/opscenter/opscenterd.conf
echo 'reported_interface='$IP >> /etc/opscenter/opscenterd.conf
echo 'incoming_interface='$IP >> /etc/opscenter/opscenterd.conf

echo "Starting OpsCenter"
sudo service opscenterd start

#
# Provision the DSE nodes
#
# wget https://raw.githubusercontent.com/J4U-Nimbus/EMJU_DataStaxARM/master/extensions/opscenter.py
# echo "Generating a provision.json file"
# echo "Going to call: python opscenter.py $1 $2 $3"
# python opscenter.py $1 $2 $3
#
# OpsCenter isn't binding to public IP on the Stomp interface, so going to comment this out for now
#echo "Provisioning a new cluster using provision.json"
#curl --insecure -H "Accept: application/json" -X POST http://127.0.0.1:8888/provision -d @provision.json
