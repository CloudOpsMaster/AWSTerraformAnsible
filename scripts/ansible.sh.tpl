#!/bin/bash

apt update -y
apt install software-properties-common -y
add-apt-repository --yes --update ppa:ansible/ansible 
apt install ansible -y
mkdir /home/ubuntu/ansible  
printf '
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/style.css">
  </head>
  <body>
     <h1>Ansible playbook for Install Apache</h1>
  </body>
</html>
' > /home/ubuntu/ansible/index.html


printf "[defaults]
host_key_checking = false
inventory = ./hosts.txt
" > /home/ubuntu/ansible/ansible.cfg
mkdir /home/ubuntu/ansible/group_vars
touch /home/ubuntu/ansible/hosts.txt


sudo printf "
[APP]
Linux1 ansible_host=${NODE0} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa
Linux2 ansible_host=${NODE1} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa

[DB]
Linux3 ansible_host=${NODE2} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa
Linux4 ansible_host=${NODE3} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa

[PROD_ALL:children]
DB
APP


[PROD_SERVERS]
${NODE0}
${NODE1} 

" > /home/ubuntu/ansible/hosts.txt 

touch /home/ubuntu/ansible/group_vars/PROD_SERVERS
printf "
---
ansible_user: ubuntu
ansible_ssh_private_key_file:/home/ubuntu/.ssh/key_rsa
" > /home/ubuntu/ansible/group_vars/PROD_SERVERS


printf "
---
- name: Test Connection to my servers
  hosts: all
  become: yes

  tasks:

  - name: Ping my servers
    ping:
"  > /home/ubuntu/ansible/playbook1.yaml


printf "
---
- hosts: all
  become: yes

  tasks:

  - name: Install apache httpd  (state=present is optional)
    apt: name=apache2 state=latest update_cache=yes

  - name: index.html
    copy:
       content: "Playbook for install apache"
       dest: /var/www/html/index.html

  - name: restart apache2
    service:
        name: apache2
        state: restarted
"  > /home/ubuntu/ansible/playbook2.yaml


printf "
---
- name: Playbook with intall apache, vars and hendlers
  hosts: all
  become: yes

  vars:
    source_file: index.html
    destination_file: /var/www/index.html


  tasks:

  - name: Install apache2
    apt: name=apache2 state=latest

  - name: index.html
    copy: src={{ source_file }} dest={{destination_file }} mode=0555
    notify: Restart Apache

  handlers:
  - name: Restart Apache
    service:
        name: apache2
        state: restarted
" > /home/ubuntu/ansible/playbook3.yaml


printf "
---
- name: My variables playbook
  hosts: all
  become: yes

  vars:
    secret: VBC56778KHJJHKJgFGFHJ89765

  tasks:

  - name: Print variable secret
    debug:
      var: secret

  - debug:
      var: ansible_distribution

  - shell: uptime
    register: results

" > /home/ubuntu/ansible/playbook4.yaml





