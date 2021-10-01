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

resource "aws_instance" "ansible" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.administration.id]
  subnet_id              = aws_subnet.public_subnet.id
  user_data = templatefile("${path.module}/scripts/ansible.sh.tpl", {
    NODE0 = aws_instance.server.0.public_ip
    NODE1 = aws_instance.server.1.public_ip
    NODE2 = aws_instance.server.2.public_ip
    NODE3 = aws_instance.server.3.public_ip
  })
  key_name = aws_key_pair.public.key_name

  provisioner "file" {
    source      = var.privatekeypath
    destination = "/home/ubuntu/.ssh/key_rsa"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.privatekeypath)
      host        = self.public_ip
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/.ssh/key_rsa",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.privatekeypath)
      host        = self.public_ip
    }
  }
  tags = {
    Project = "awsAnsible"
    Name    = "Ansible"
  }
  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_instance" "server" {
  count                  = var.instance_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.administration.id]
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = aws_key_pair.public.key_name


  provisioner "file" {
    source      = var.privatekeypath
    destination = "/home/ubuntu/.ssh/key_rsa"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.privatekeypath)
      host        = self.public_ip
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/.ssh/key_rsa",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.privatekeypath)
      host        = self.public_ip
    }
  }
  tags = {
    Project = "awsAnsible"
    Name    = "server"
  }
  lifecycle {
    create_before_destroy = true
  }
}
