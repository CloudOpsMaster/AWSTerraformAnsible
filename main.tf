
provider "aws" {
    region = "us-west-1"
}


resource "aws_instance" "Ansible" {
    ami = "ami-0d382e80be7ffdae5"
    instance_type = "t2.micro"
    user_data = file("init_scripts/ansible.sh" )
    key_name      = "aws_key"

     network_interface {
    network_interface_id = aws_network_interface.ansible.id
    device_index         = 0
  }


  tags = {
    Owner   = "Vadim Tailor"
    Project = "awsAnsible"
    Name    = "Ansible"
  }

  lifecycle {
    create_before_destroy = true
  }
  
}