#!/bin/bash
REGION=$(aws configure get region)
echo $REGION
ACCOUNT=$(aws --output text sts get-caller-identity | cut -f1)
echo $ACCOUNT
docker build . -t hug
docker tag hug:latest $ACCOUNT.dkr.ecr.$REGION.amazonaws.com/hug
COMMAND=$(aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT.dkr.ecr.$REGION.amazonaws.com)
eval #COMAND
docker push $ACCOUNT.dkr.ecr.$REGION.amazonaws.com/hug
