# Create/provision elearning project 

module "e-learning-project" {
    source                          = "../module-https"

    region                          = var.region
    project_name                    = var.project_name
    #filters list of Availability Zones based on their current state. 
    #can be either "available", "information", "impaired" or "unavailable"
    state                           = var.state

#Development VPC
    vpc_cidr                        = var.vpc_cidr
    instance-tenancy                = var.instance-tenancy
    vpc-dns-hostnames               = var.vpc-dns-hostnames
    vpc_dns_support                 = var.vpc_dns_support

    public-subnet_ids               = var.public-subnet_ids
    private-subnet_ids              = var.private-subnet_ids

# public route table
    public-route-table              = var.public-route-table

# private route table
    private-route-table             = var.private-route-table

#Internet gateway to communicate with public route table
    igw-Name                        = var.igw-Name

# Route igw to associate with public route table
    destin-cidr_block               = var.destin-cidr_block

#provision elastic IP for public NAT Gateway
    vpc_elastic-ip                  = var.vpc_elastic-ip
    eip-Name                        = var.eip-Name
   
# public NAT gateway put in a public subnet
    NAT-connectivity_type           = var.NAT-connectivity_type    
    NAT-Name                        = var.NAT-Name

# Route NAT gateway association with private route table
    NAT-destin-cidr_block           = var.NAT-destin-cidr_block

## Application Load Balancer to direct traffic to instances in private subnets 
    alb-name                          = var.alb-name
    alb-default-direction             = var.alb-default-direction
    alb-type                          = var.alb-type
    alb-environment                   = var.alb-environment

# Target Group for alb listeners
    target-grup-name                   = var.target-grup-name
    target-grup-port                   = var.target-grup-port
    target-grup-protocol               = var.target-grup-protocol
    target-grup-type                   = var.target-grup-type
    target-grup-protocol-version       = var.target-grup-protocol-version


## load balancer listeners for HTTP:80 
    listener-port-1                    = var.listener-port-1
    listener-protocol-1                = var.listener-protocol-1


## load balancer listeners for HTTPS:443

#ssl certificate issued
    listener-port-2                    = var.listener-port-2
    listener-protocol-2                = var.listener-protocol-2

## Pull the created application private image pushed to ECR, from ECR

 # Create ECS Cluster 
    ecs-cluster-name                   = var.ecs-cluster-name

## Create ECS Service which defines the ECS Cluster
    ecs-service-name                   = var.ecs-service-name
    desired-task-count                 = var.desired-task-count
    ecs-launch-type                    = var.ecs-launch-type

    assign-publicip-task               = var.assign-publicip-task

    lb-container-name                  = var.lb-container-name
    lb-container-port                  = var.lb-container-port


# Manages a revision of an ECS task definition to be used in aws_ecs_service.
    ecs-taskdef-family                 = var.ecs-taskdef-family
    ecs-taskdef-netwk-mode             = var.ecs-taskdef-netwk-mode
    taskdef-capabilities               = var.taskdef-capabilities
   
# ecs container definition - mapped/ assigned ports 80 & 443
    container-count1                   = var.container-count1
    container-cpu                      = var.container-cpu
    container-memory                   = var.container-memory
    container-def-essential            = var.container-def-essential
    
    container-port                     = var.container-port
    host-port                          = var.host-port

    
## ECS Service Application Autoscaling
    ecs-tasks-max                     = var.ecs-tasks-max
    ecs-tasks-min                     = var.ecs-tasks-min
    ecs-scale-dimension               = var.ecs-scale-dimension
    ecs-service-namespace             = var.ecs-service-namespace

    autoscale-policy-name             = var.autoscale-policy-name
    autoscale-policy-type             = var.autoscale-policy-type
    stepscale-adjustment-type         = var.stepscale-adjustment-type
    stepscale-cooldown                = var.stepscale-cooldown
    stepscale-metric-aggretype        = var.stepscale-metric-aggretype
    step-adjustmetric-upperlimit      = var.step-adjustmetric-upperlimit
    step-adjustment-scaler            = var.step-adjustment-scaler


## Cloudwatch metric alarm set to ALB and SNS 
    alarm-name                        = var.alarm-name
    alarm-comparator                  = var.alarm-comparator
    alarm-evaluation                  = var.alarm-evaluation
    alarm-metric-name                 = var.alarm-metric-name
    ecs-metric-namespace              = var.ecs-metric-namespace
    alarm-period                      = var.alarm-period
    alarm-stats                       = var.alarm-stats
    alarm-threshold                   = var.alarm-threshold
    alarm-description                 = var.alarm-description


/* RDS instance using PostgreSQL (ports to be opened are 5432, 80 and 443) */
    db-storage-type                 = var.db-storage-type
    db-allocated_storage            = var.db-allocated_storage
    db-max_allocated_storage        = var.db-max_allocated_storage
    db_instance-name                = var.db_instance-name
    rds-engine-type                 = var.rds-engine-type
    db-engine-versions              = var.db-engine-versions
    db-instance-class               = var.db-instance-class
    db_instance-username            = var.db_instance-username
    db_instance-secret_password     = var.db_instance-secret_password
    db-port                         = var.db-port
    db-final-snapshot               = var.db-final-snapshot
    db-multi_az                     = var.db-multi_az
    db-AZ                           = var.db-AZ
    db-tag-name                     = var.db-tag-name 

## Route53
    zone-name                       = var.zone-name
    record-name                     = var.record-name
    alias-record-type               = var.alias-record-type
    alias-target-evaluate           = var.alias-target-evaluate

## Provides an SNS topic resource
    topic-name                         = var.topic-name
    sns-topic-protocol                 = var.sns-topic-protocol
    subscription-endpoint              = var.subscription-endpoint

}
