# vm-project

For some reason using ssh command in script still requires password, but if I interrupt the script after virsh start $2, wait for new ip to be assigned and do command manually it works without password. I do not know why it works this way. Otherwise it should work just fine. I tried saving ssh-userdir and ssh-hostkeys to save ssh key from GI.
