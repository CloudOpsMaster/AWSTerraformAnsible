resource "aws_security_group" "administration" {
name = "administration"
description = "Allow port 22 and icmp" 
vpc_id = aws_vpc.vpc.id 
tags = {
    Name = "administration"
    Project = "Ansible"
}

ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}