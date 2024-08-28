#!/bin/bash
VM_NAME=$1
IP=$(virsh net-dhcp-leases default | grep $VM_NAME | awk '{ print $5}')
CIP=${IP%???}
ssh jenkins@${CIP} sudo ufw status &&
        sudo systemctl status nginx
curl ${CIP}:80
