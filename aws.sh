#!/bin/bash

USER_DATA_FILE="install-nginx.sh"

ID=$(
aws ec2 run-instances \
    --region us-east-1 \
    --image-id ami-0ebfd941bbafe70c6 \
    --instance-type t2.micro \
    --key-name MyKeyPair \
    --security-group-ids sg-053db75f5fff9aefe \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=nginxer}]' \
    --user-data file://"$USER_DATA_FILE" \
    --query 'Instances[0].InstanceId' \
    --output text
    )
echo $ID

IP=$(
aws ec2 describe-instances \
    --instance-ids "$ID" \
    --query 'Reservations[*].Instances[*].PublicIpAddress' \
    --output text
    )
echo $IP

sleep 60
ssh -i MyKeyPair.pem -o "StrictHostKeyChecking=accept-new" \
    ec2-user@$IP curl localhost
curl $IP

aws ec2 terminate-instances --instance-ids "$ID"