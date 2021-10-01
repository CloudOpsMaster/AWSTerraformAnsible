#!/bin/bash

apt update -y
apt install software-properties-common -y
add-apt-repository --yes --update ppa:ansible/ansible 
apt install ansible -y
mkdir /home/ubuntu/ansible  
touch /home/ubuntu/ansible/host.txt
sudo printf "
[app]
Linux1 ansible_host=${NODE0} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa
Linux2 ansible_host=${NODE1} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa

[db]
Linux3 ansible_host=${NODE2} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa
Linux4 ansible_host=${NODE3} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa
" > /home/ubuntu/ansible/host.txt 
