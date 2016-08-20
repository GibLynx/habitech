#!/bin/bash

ENV_TYPE=bld
IMG_NAME=$PROJECT-mysql-$ENV_TYPE
CONT_NAME=${PROJECT}_mysql_${ENV_TYPE}

sudo docker build --file=Dockerfile.$ENV_TYPE -t $IMG_NAME .
sudo docker run --name=$CONT_NAME --volume=$PWD/tar:$CONT_TAR $IMG_NAME

ENV_TYPE=prod
IMG_NAME=$PROJECT-mysql-$ENV_TYPE
CONT_NAME=${PROJECT}_mysql_${ENV_TYPE}

sudo docker build --file=Dockerfile.$ENV_TYPE -t $IMG_NAME .
sudo docker run --name=$CONT_NAME --volume=$PWD/db:$CONT_DB -d $IMG_NAME
