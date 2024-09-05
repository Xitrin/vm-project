#!/bin/bash
VM_NAME=$1
IP=$(virsh net-dhcp-leases default | grep $VM_NAME | awk '{ print $5}')
CIP=${IP%???}
ssh -o "StrictHostKeyChecking=accept-new" jenkins@${CIP} \
    sudo docker pull nginx \
    sudo docker run --name docker-nginx -p 80:80 -d nginx
# ansible-playbook -i ansible/inventory/hosts ansible/playbook-nginx.yml
# ssh -o "StrictHostKeyChecking=accept-new" jenkins@${CIP} \
#         sudo apt install -y nginx &
# 	sleep 10
