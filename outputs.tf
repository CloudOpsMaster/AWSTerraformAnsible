
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "vpcs" {}
data "aws_availability_zones" "working" {}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}
output "data_aws_region_name" {
  value = data.aws_region.current.name
}
output "data_aws_region_description" {
  value = data.aws_region.current.description
}
output "aws_vpcs" {
  value = data.aws_vpcs.vpcs.ids
}
output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}
output "vpc_cidr" {
  value = resource.aws_vpc.vpc.cidr_block
}
output "SAnsible_public_ip" {
  value =  aws_instance.ansible.public_ip
}
output "server1" {
  value =  aws_instance.server.0.public_ip
}
output "server2" {
  value =  aws_instance.server.1.public_ip
}
output "server3" {
  value =  aws_instance.server.2.public_ip
}
output "server4" {
  value =  aws_instance.server.3.public_ip
}





