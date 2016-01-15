#!/bin/sh

RESOURCE_GROUP=$1

azure group create $1 "West US"
azure group deployment create -v -f templates/mainTemplate.json -e parameters/prod.parameters.json $RESOURCE_GROUP dse

