#!/bin/bash
VM_NAME=$1
virsh destroy $VM_NAME
virsh undefine $VM_NAME --remove-all-storage --nvram
rm ansible/inventory/hosts
echo "Inventory removed"
