#!/bin/bash

ENV_TYPE=bld
IMG_NAME=$PROJECT-go-$ENV_TYPE
CONT_NAME=${PROJECT}_go_${ENV_TYPE}

sudo docker build --build-arg PORT=$CONT_PORT --file=Dockerfile.$ENV_TYPE -t $IMG_NAME .
sudo docker run --name=$CONT_NAME --volume=$PWD/src/$PROJECT:$CONT_SRC --volume=$PWD/bin:$CONT_BIN $IMG_NAME

ENV_TYPE=prod
IMG_NAME=$PROJECT-go-$ENV_TYPE
CONT_NAME=${PROJECT}_go_${ENV_TYPE}

sudo docker build --build-arg PORT=$CONT_PORT --file=Dockerfile.$ENV_TYPE -t $IMG_NAME .
sudo docker run --name=$CONT_NAME --publish=$PROD_PORT:$CONT_PORT -d $IMG_NAME
