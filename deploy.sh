#!/bin/bash
VM_NAME=$1
IP=$(virsh net-dhcp-leases default | grep $VM_NAME | awk '{ print $5}')
CIP=${IP%???}
ssh -o "StrictHostKeyChecking=accept-new" jenkins@${CIP} \
        sudo apt install -y nginx &
	sleep 10
