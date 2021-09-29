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

