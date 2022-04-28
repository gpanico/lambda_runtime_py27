#!/bin/bash

aws_account="`aws sts get-caller-identity --query 'Account' --output text`"

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $aws_account.dkr.ecr.us-east-1.amazonaws.com
docker build -t py27lambdas .
docker tag py27lambdas:latest $aws_account.dkr.ecr.eu-west-1.amazonaws.com/py27lambdas:latest
docker push $aws_account.dkr.ecr.eu-west-1.amazonaws.com/py27lambdas:latest

echo WARNING: create the lambda function with entrypoint /var/runtime/bootstrap!!!
