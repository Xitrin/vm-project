#!/bin/bash

AWS_PROFILE="default"
cd terraform

terraform init

terraform validate

terraform apply -auto-approve

IP=$(terraform output -raw instance_ip)

sleep 60

ssh -i MyKeyPair.pem -o "StrictHostKeyChecking=accept-new" \
    ec2-user@$IP curl localhost
curl $IP

terraform destroy -auto-approve