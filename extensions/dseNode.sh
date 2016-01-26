#!/bin/bash

echo $(basename "$0") "$@"

# Determine Fault Domain used to create the Rack name to create rackdc.properties 
# to allow cassandra to place each of 3 replicas on separate fault domains
fault_domain=$(curl http://169.254.169.254/metadata/v1/InstanceInfo -s -S | sed -e 's/.*"FD":"\([^"]*\)".*/\1/')
if [ ! "$fault_domain" ]; then
	echo Unable to retrieve Instance Fault Domain from instance metadata server 1>&2
	exit 99
fi
echo Fault Domain: "$fault_domain"
echo ""

echo "Installing Azul Zulu JDK"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
apt-add-repository -y "deb http://repos.azulsystems.com/ubuntu stable main"
apt-get -y update
apt-get -y install zulu-8

echo "Partitioning and formatting all attached data disks"
bash vm-disk-utils-0.1.sh

echo "Modifying permissions"
chmod 777 /mnt
