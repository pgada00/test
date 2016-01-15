#!/bin/sh

RESOURCE_GROUP=$1

azure group create $1 "US West"
azure group deployment create -f templates/mainTemplate.json -e parameters/prod.parameters.json $RESOURCE_GROUP dse

