variable "region" {
  description = "west-1 region"
  default =  "us-west-1"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "public_cidr" {
  default = "192.168.0.0/24"
}

variable "publickeypath" {
  type = string
  default = "C:/terraform/AWS/.ssh/key_rsa.pub"
}

variable "privatekeypath" {
  type = string
  default = "C:/terraform/AWS/.ssh/key_rsa"
}


data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}