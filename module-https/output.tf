output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "aws_vpc_id" {
  value = "${aws_vpc.elearning-VPC.id}"
}

output "aws_vpc_cidr_block" {
  value = "${aws_vpc.elearning-VPC.cidr_block}"
}

output "aws_subnet_public-subnets_ids" {
  value = "${aws_subnet.public-subnets[*].id}"
}

output "aws_subnet_public-subnets_cidr" {
  value = "${aws_subnet.public-subnets[*].cidr_block}"
}

output "aws_subnet_private-subnets_ids" {
  value = "${aws_subnet.private-subnets[*].id}"
}

output "aws_subnet_private-subnets_cidr" {
  value = "${aws_subnet.private-subnets[*].cidr_block}"
}


output "aws_route_table_public_route-table" {
  value = "${aws_route_table.elearn-public-rtb.id}"
}

output "aws_route_table_private_route-table" {
  value = "${aws_route_table.elearn-private-rtb.id}"
}

output "aws_internet_gateway_cloudrk_igw_id" {
  value = "${aws_internet_gateway.elearning-igw.id}"
}

output "aws_route_igw_association_public-rtb" {
  value = "${aws_route.elearning-igw-association.id}"
}

output "aws_nat_gateway_public_NAT_gateway_id" {
  value = "${aws_nat_gateway.elearning-Nat-gateway.id}"
}

output "aws_route_NAT_association_priv-rtb" {
  value = "${aws_route.elearning-Nat-association.id}"
}

output "aws_db-instance_id" {
  value = "${aws_db_instance.elearn-db.id}"
}

output "aws_db-instance_allocated_storage" {
  value = "${aws_db_instance.elearn-db.allocated_storage}"
}

output "aws_db-instance_max_storage" {
  value = "${aws_db_instance.elearn-db.max_allocated_storage}"
}

output "aws_db-instance_password" {
  sensitive = true
  value = var.db_instance-secret_password
}

output "db_instance-name" {
  value = var.db_instance-name
}

output "ecs-desired-task-count" {
  value = var.desired-task-count
}

output "aws_vpc-task_security_group-name" {
  value = aws_security_group.alb-security-group.tags
}

