output "vpc_id" {
  description = "ID of the main VPC"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value = [
    aws_subnet.public_subnet_az1.id,
    aws_subnet.public_subnet_az2.id
  ]
}

output "private_app_subnet_ids" {
  description = "IDs of the private application subnets"
  value = [
    aws_subnet.private_app_subnet_az1.id,
    aws_subnet.private_app_subnet_az2.id
  ]
}

output "private_db_subnet_ids" {
  description = "IDs of the private database subnets"
  value = [
    aws_subnet.private_db_subnet_az1.id,
    aws_subnet.private_db_subnet_az2.id
  ]
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.main_igw.id
}

output "nat_gateway_id" {
  description = "ID of the NAT gateway"
  value       = aws_nat_gateway.main_nat_gateway.id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public_route_table.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private_route_table.id
}

output "public_security_group_id" {
  value = aws_security_group.public_sg.id
}

output "private_security_group_id" {
  value = aws_security_group.private_sg.id
}