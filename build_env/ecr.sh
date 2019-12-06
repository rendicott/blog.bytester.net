#!/bin/bash
REGION=$(aws configure get region)
ACCOUNT=$(aws --output text sts get-caller-identity | cut -f1)
docker build . -t hug
docker tag hug:latest $ACCOUNT.dkr.ecr.$REGION.amazonaws.com/hug
COMMAND=$(aws ecr get-login --region $REGION --no-include-email)
eval #COMAND
docker push $ACCOUNT.dkr.ecr.$REGION.amazonaws.com/hug
