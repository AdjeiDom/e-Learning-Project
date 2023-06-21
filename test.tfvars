
region = "us-west-1"
project_name = "e-learning-platform"
#filters list of Availability Zones based on their current state. 
#can be either "available", "information", "impaired" or "unavailable"
state = "available"

#DEV VPC
vpc_cidr = "10.0.0.0/22"
instance-tenancy = "default"
vpc-dns-hostnames = true
vpc_dns_support = true

#Subnet Definitions  
public-subnet_ids = ["10.0.0.0/24", "10.0.1.0/24"]
private-subnet_ids = ["10.0.2.0/24","10.0.3.0/24"]

# public route table
public-route-table = "elearn-public-rtb"
   
# private route table
private-route-table = "elearn-private-rtb"
    
#Internet gateway to communicate with public route table
igw-Name = "elearning-igw"
    
# Route igw to associate with public route table
destin-cidr_block = "0.0.0.0/0"
    
#provision elastic IP for public NAT Gateway
vpc_elastic-ip = true
eip-Name = "elearn-EIP"
    
# public NAT gateway put in a public subnet
NAT-connectivity_type = "public"
NAT-Name = "elearning-Nat-gateway"

# Route NAT gateway association with private route table
NAT-destin-cidr_block = "0.0.0.0/0"

## Application Load Balancer to direct traffic to instances in private subnets 
alb-name = "elearn-alb"
alb-default-direction = "false"         # internal or external (public)
alb-type      = "application"           # application, gateway or network
alb-environment = "test"

# Target Group for alb listeners
target-grup-name = "elearn-http-target"
target-grup-port = "80"
target-grup-protocol = "HTTP"               # http, https
target-grup-type = "ip"                     # instance, ip, alb & lambda.
target-grup-protocol-version  = "HTTP1"     # applicable when protocol is HTTP or HTTPS. GRPC, HTTP1, HTTP2 


## load balancer listeners for HTTP:80
listener-port-1   =   "80"
listener-protocol-1   =   "HTTP"
listener-action-type   =   "forward"        # Type of routing action: forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc

# Create ECS Cluster 
ecs-cluster-name           = "cloudgigs-fargate-cluster"


## Create ECS Service which defines the ECS Cluster
ecs-service-name          = "ecs-elearning-service"
desired-task-count        = 2
ecs-launch-type           = "FARGATE"

assign-publicip-task      = true 

lb-container-name         = "e-learning"
lb-container-port         = 80


# Manages a revision of an ECS task definition to be used in aws_ecs_service.
ecs-taskdef-family = "elearn-service"
ecs-taskdef-netwk-mode = "awsvpc"
taskdef-capabilities  = ["FARGATE"]

# ecs container definition - mapped/ assigned ports 80 & 443
container-count1       = "e-learning"
container-cpu           = 256
container-memory        = 512
container-def-essential = true
container-port          = 80
host-port               = 80


# ECS Service Application Autoscaling
ecs-tasks-max               =   4
ecs-tasks-min               =   1
ecs-scale-dimension         =   "ecs:service:DesiredCount"
ecs-service-namespace       =   "ecs"

autoscale-policy-name       =   "ecs-autoscale-policy"
autoscale-policy-type       =   "StepScaling"           # StepScaling & TargetTrackingScaling
stepscale-adjustment-type   =   "ChangeInCapacity"    # adjustment may be absolute number or a percentage of the current capacity. ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity.
stepscale-cooldown          =   300  
stepscale-metric-aggretype  =   "Maximum"
step-adjustmetric-upperlimit=   0
step-adjustment-scaler      =   -1


## Cloudwatch metric alarm set to ALB and SNS 
alarm-name          =   "elearn-alarm"   
alarm-comparator    =   "GreaterThanOrEqualToThreshold"   # "LessThanThreshold"
alarm-evaluation    =   2
alarm-metric-name   =   "CPUUtilization"            #"HealthyHostCount"
ecs-metric-namespace   =   "AWS/ECS"
alarm-period        =   60
alarm-stats         =   "Average"
alarm-threshold     =   80
alarm-description   =   "This metric monitors ecs cpu utilization"          #"number of healthy nodes in Target Group"


/* RDS instance using PostgreSQL (ports to be opened are 5432, 80 and 443)*/
db-storage-type    = "gp2"
db-allocated_storage = 20
db-max_allocated_storage = 100
db_instance-name = "elearn0db"
rds-engine-type = "postgres"
db-engine-versions = ["14.6", "13.3", "12.7"]
db-instance-class = "db.t3.micro" 

db_instance-username = "elearn"
db_instance-secret_password = "ADJany100"

db-port            = 5432
db-final-snapshot = true
db-multi_az        = false

db-AZ              = "us-west-1b"
db-tag-name        = "elearn-db"


## Route53
zone-name             = "betheldom-cloud-academy.click"
record-name           = "betheldom-cloud-academy.click"
alias-record-type     = "A"
alias-target-evaluate = true 


## Provides an SNS topic resource
topic-name            =   "user-updates"        
sns-topic-protocol    =   "email"       
subscription-endpoint =   "dominic.annang@gmail.com"

                              