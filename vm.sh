#!/bin/bash
w=$(virt-sysprep --list-operations | egrep -v 'fs-uuids|ssh-hostkeys|ssh-userdir' | awk '{ printf "%s,", $1}' | sed 's/,$//')
virt-clone --original $1 --name $2 --auto-clone
sudo virt-sysprep -d $2 --hostname $2 --enable $w --keep-user-accounts jenkins --firstboot-command 'dpkg-reconfigure openssh-server'
virsh start $2
sleep 20
IP=$(virsh net-dhcp-leases default | grep $2 | awk '{ print $5}')
CIP=${IP%???}
ssh -o "StrictHostKeyChecking=accept-new" jenkins@${CIP} systemctl status nginx
curl ${CIP}:80
sleep 5
virsh destroy $2
virsh undefine $2
sudo rm /var/lib/libvirt/images/$2.qcow2
