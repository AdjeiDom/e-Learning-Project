/* RDS instance using PostgreSQL (ports to be opened are 5432, 80 and 443) */
resource "aws_db_instance" "elearn-db" {
  storage_type            = var.db-storage-type
  identifier              = "elearning"
  allocated_storage       = var.db-allocated_storage
  max_allocated_storage   = var.db-max_allocated_storage
  db_name               = var.db_instance-name
  engine                = var.rds-engine-type
  engine_version        = var.db-engine-versions[0]
  instance_class        = var.db-instance-class
  username              = var.db_instance-username  
  password              = var.db_instance-secret_password
  port                   = var.db-port
  skip_final_snapshot   = var.db-final-snapshot
  multi_az              = var.db-multi_az 
  
  db_subnet_group_name    = aws_db_subnet_group.db-subnets.name
  vpc_security_group_ids  =  [aws_security_group.alb-security-group.id]
  availability_zone       =  var.db-AZ

  tags = {
    Name = var.db-tag-name
  }
}

## AWS_DB_SUBNET_GROUP
## Provides an RDS DB subnet group resource

resource "aws_db_subnet_group" "db-subnets" {
  name       = "db-subnets"
  subnet_ids = [for subnet in aws_subnet.private-subnets : subnet.id]
  tags = {
    Name = "db-subnet-group"
  }
}