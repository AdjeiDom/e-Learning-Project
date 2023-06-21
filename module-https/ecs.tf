## Pull the created application private image pushed to ECR, from ECR

data "aws_ecr_repository" "e-learning" {
  name = "cloudgigsacademy.com"
}


# Create ECS Cluster 
resource "aws_ecs_cluster" "cloudgigs-cluster" {
  name = var.ecs-cluster-name
}


## Create ECS Service which defines the ECS Cluster 

resource "aws_ecs_service" "ecs-elearning-service" {
  name                  = var.ecs-service-name
  cluster               = aws_ecs_cluster.cloudgigs-cluster.id
  task_definition       = aws_ecs_task_definition.elearn-service.arn
  desired_count         = var.desired-task-count
  launch_type           = var.ecs-launch-type
  
  depends_on            = [aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment, aws_lb_listener.elearn-alb-listener1]   # aws_lb_listener.elearn-alb-listener2,
 
  network_configuration {
    subnets             = [for subnet in aws_subnet.private-subnets : subnet.id]
    assign_public_ip    = var.assign-publicip-task
    security_groups     = [aws_security_group.alb-security-group.id]
  }

  load_balancer {
    target_group_arn    = aws_lb_target_group.elearn-http-target.arn
    container_name      = var.lb-container-name
    container_port      = var.lb-container-port 
  }
}

# Manages a revision of an ECS task definition to be used in aws_ecs_service.

resource "aws_ecs_task_definition" "elearn-service" {
  family                        = var.ecs-taskdef-family
  execution_role_arn            = aws_iam_role.ecs_task_execution_role.arn 
  network_mode                  = var.ecs-taskdef-netwk-mode
  requires_compatibilities      = var.taskdef-capabilities
  cpu                           = var.container-cpu
  memory                        = var.container-memory
  container_definitions         = jsonencode([                              
    {
      name      = var.container-count1
      image     = "983757010247.dkr.ecr.us-west-1.amazonaws.com/cloudgigsacademy.com:latest"
      cpu       = var.container-cpu
      memory    = var.container-memory
      essential = var.container-def-essential
      portMappings = [
        {
          containerPort = var.container-port
          hostPort      = var.host-port
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
    }

  ])
}


# ECS Service Application Autoscaling
resource "aws_appautoscaling_target" "ecs-appscale-target" {
  max_capacity       = var.ecs-tasks-max
  min_capacity       = var.ecs-tasks-min
  resource_id        = "service/${aws_ecs_cluster.cloudgigs-cluster.name}/${aws_ecs_service.ecs-elearning-service.name}"
  scalable_dimension = var.ecs-scale-dimension 
  service_namespace  = var.ecs-service-namespace
  role_arn           = aws_iam_role.asg_appscaling_role.arn
}


resource "aws_appautoscaling_policy" "ecs-autoscale-policy" {
  name               = var.autoscale-policy-name
  policy_type        = var.autoscale-policy-type
  resource_id        = aws_appautoscaling_target.ecs-appscale-target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs-appscale-target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs-appscale-target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = var.stepscale-adjustment-type
    cooldown                = var.stepscale-cooldown
    metric_aggregation_type = var.stepscale-metric-aggretype

    step_adjustment {
      metric_interval_upper_bound = var.step-adjustmetric-upperlimit
      scaling_adjustment          = var.step-adjustment-scaler
    }
    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 2
    }
  }
}