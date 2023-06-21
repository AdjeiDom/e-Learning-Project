
#ecs_task_execution_IAM role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "execution-role-name"
 
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["ecs-tasks.amazonaws.com"]
        }
      }
    ]
  })
}

# Define the IAM role for policies attachement for the task execution role 

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}



# Application auto scaling group_IAM_role
resource "aws_iam_role" "asg_appscaling_role" {
  name = "app-auto-scaling-groug-role-name"
 
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "sts:AssumeRole"
      ]
      Principal = {
        "Service" : "application-autoscaling.amazonaws.com"
      }
      "Effect" : "Allow"
      
    }]
  })
}





  