provider "aws" {
  region = var.region
}

resource "aws_key_pair" "public" {
  key_name   = "public"
  public_key = file(var.publickeypath)
  tags = {
    Name    = "Ansible project keypair."
    Project = "Ansible"
  }
}

resource "aws_instance" "Ansible" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.administration.id ]
  subnet_id = aws_subnet.public_subnet.id
  user_data     = file("init_scripts/ansible.sh")
  key_name      = aws_key_pair.public.key_name

  tags = {
    Project = "awsAnsible"
    Name    = "Ansible"
  }

  lifecycle {
    create_before_destroy = true
  }
}
