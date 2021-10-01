generate keys:
    ssh-keygen -t rsa

cd ~
mkdir ansible  
cd ansible
nano host.txt  
    [app]
    Linux1 ansible_host=54.183.223.51 ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa
    Linux2 ansible_host=3.101.24.181 ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa

    [db]
    Linux3 ansible_host=54.193.178.15 ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa
    Linux4 ansible_host=204.236.153.154 ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/key_rsa

ansible -i host.txt all -m ping

    