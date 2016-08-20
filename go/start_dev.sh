#!/bin/bash

set -e

ENV_TYPE=dev
IMG_NAME=$PROJECT-go-$ENV_TYPE
CONT_NAME=${PROJECT}_go_${ENV_TYPE}

sudo docker build --build-arg PORT=$CONT_PORT --file=Dockerfile.$ENV_TYPE -t $IMG_NAME .
sudo docker run --name=$CONT_NAME -it --volume=$PWD/src/$PROJECT:$CONT_SRC --publish=$DEV_PORT:$CONT_PORT $IMG_NAME
