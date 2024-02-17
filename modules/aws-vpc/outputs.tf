# Arquivo: modules/aws-vpc/outputs.tf

output "vpc_id" {
  value = aws_vpc.example_vpc.id
  description = "The ID of the VPC"
}

output "subnet_id" {
  value = aws_subnet.example_subnet.id
  description = "The ID of the Subnet"
}

output "internet_gateway_id" {
  value = aws_internet_gateway.example_gw.id
  description = "The ID of the internet gateway"
}

output "internet_route_table_id" {
  value = aws_route_table.example_route_table.id
  description = "The ID of the route table"
}

output "internet_table_assoc_id" {
  value = aws_route_table_association.example_rt_assoc.id
  description = "The ID of the route table association"
}

output "security_group_id" {
  value = aws_security_group.example_sg.id
  description = "The ID of the security group"
}