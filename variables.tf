 
variable "region" {}
variable "project_name" {}
#filters list of Availability Zones based on their current state. 
#can be either "available", "information", "impaired" or "unavailable"
variable "state" {}

#Production VPC
variable "vpc_cidr" {}
variable "instance-tenancy" {}
variable "vpc-dns-hostnames" {}
variable "vpc_dns_support" {}

variable "public-subnet_ids" {}
variable "private-subnet_ids" {}

# public route table
variable "public-route-table" {}

# private route table
variable "private-route-table" {}


#Internet gateway to communicate with public route table
variable "igw-Name" {}

# Route igw to associate with public route table
variable "destin-cidr_block" {}

#provision elastic IP for public NAT Gateway
variable "vpc_elastic-ip" {}
variable "eip-Name" {}

# public NAT gateway put in a public subnet
variable "NAT-connectivity_type" {}
variable "NAT-Name" {}

# Route NAT gateway association with private route table
variable "NAT-destin-cidr_block" {}


## Application Load Balancer to direct traffic to instances in private subnets 
variable "alb-name" {}
variable "alb-default-direction" {}
variable "alb-type" {}
variable "alb-environment" {}

# Target Group for alb listeners
variable "target-grup-name" {}
variable "target-grup-port" {}
variable "target-grup-protocol" {}
variable "target-grup-type" {}
variable "target-grup-protocol-version" {}


## load balancer listeners for HTTP:80 
variable "listener-port-1" {}
variable "listener-protocol-1" {}
variable "listener-action-type" {} 

## Pull the created application private image pushed to ECR, from ECR

# Create ECS Cluster 
variable "ecs-cluster-name" {}

# Define the IAM role for the ECS task execution (AmazonECSTaskExecutionRolePolicy)

## Create ECS Service which defines the ECS Cluster
variable "ecs-service-name" {}
variable "desired-task-count" {}
variable "ecs-launch-type" {}

variable "assign-publicip-task" {}

variable "lb-container-name" {}
variable "lb-container-port" {}

# Manages a revision of an ECS task definition to be used in aws_ecs_service.
variable "ecs-taskdef-family" {}
variable "ecs-taskdef-netwk-mode" {}
variable "taskdef-capabilities" {}
variable "container-cpu" {}
variable "container-memory" {}
# ecs container definition - mapped/ assigned ports 80 & 443
variable "container-count1" {}
variable "container-def-essential" {}
variable "container-port" {}
variable "host-port" {}


## ECS Service Application Autoscaling
variable "ecs-tasks-max" {}
variable "ecs-tasks-min" {}

variable "ecs-scale-dimension" {}
variable "ecs-service-namespace" {}

variable "autoscale-policy-name" {}
variable "autoscale-policy-type" {}
variable "stepscale-adjustment-type" {}
variable "stepscale-cooldown" {}
variable "stepscale-metric-aggretype" {}
variable "step-adjustmetric-upperlimit" {}
variable "step-adjustment-scaler" {}


## Cloudwatch metric alarm set to ALB and SNS 
variable "alarm-name" {}  
variable "alarm-comparator" {}
variable "alarm-evaluation" {}
variable "alarm-metric-name" {}
variable "ecs-metric-namespace" {}
variable "alarm-period" {}
variable "alarm-stats" {}
variable "alarm-threshold" {}
variable "alarm-description" {}


/* RDS instance using PostgreSQL (ports to be opened are 5432, 80 and 443) */
variable "db-storage-type" {}
variable "db-allocated_storage" {}
variable "db-max_allocated_storage" {}
variable "db_instance-name" {}
variable "rds-engine-type" {}
variable "db-engine-versions" {}
variable "db-instance-class" {}
variable "db_instance-username" {}
variable "db_instance-secret_password" {}
variable "db-port" {} 
variable "db-final-snapshot" {}
variable "db-multi_az" {}
variable "db-AZ" {}
variable "db-tag-name" {}

## Route53
variable "zone-name" {}
variable "record-name" {}
variable "alias-record-type" {}
variable "alias-target-evaluate" {}

## Provides an SNS topic resource
variable "topic-name" {}
variable "sns-topic-protocol" {}
variable "subscription-endpoint" {}
