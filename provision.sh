#!/bin/bash
GI_NAME=$1
VM_NAME=$2
w=$(virt-sysprep --list-operations | \
        egrep -v 'fs-uuids|ssh-hostkeys|ssh-userdir' | \
        awk '{ printf "%s,", $1}' | sed 's/,$//')
virt-clone --original $GI_NAME --name $VM_NAME --auto-clone
sudo virt-sysprep -d $VM_NAME --hostname $VM_NAME --enable $w \
        --keep-user-accounts jenkins \
        --firstboot-command 'dpkg-reconfigure openssh-server'
virsh start $VM_NAME
sleep 20
IP=$(virsh net-dhcp-leases default | grep $VM_NAME | awk '{ print $5}')
CIP=${IP%???}
# echo > ansible/inventory/hosts "[clones]
# $CIP ansible_user=jenkins"
# echo "Created Inventory"
