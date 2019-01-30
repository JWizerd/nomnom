#!/bin/bash

# source config vars
. ./config.sh

# run the mongo submodule which creates the net and runs the db
. ../mongo/docker/dev/run.sh

echo "Running $service docker image..."
docker rm -f $service
docker run --name="$service" \
    --log-opt max-size=25m \
    --log-opt max-file=4 \
    -c 5120 \
    -m 1g \
    	-e "env=dev" \
	-e "version=stage" \
	-p $externalPort:$appPort \
	-v ${PWD}/../../src/:/var/www/html/ \
	-d $service

docker ps
