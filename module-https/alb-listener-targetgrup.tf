## Application Load Balancer to direct traffic to instances in private subnets 
resource "aws_lb" "elearn-alb" {
  name               = var.alb-name
  internal           = var.alb-default-direction
  load_balancer_type = var.alb-type                     
  security_groups    = [aws_security_group.alb-security-group.id]
  
  subnets            = [for subnet in aws_subnet.public-subnets : subnet.id]
 
  tags = {
    Name            = var.alb-name
    Environment     = var.alb-environment
  }
}

# Target Group for alb listeners
resource "aws_lb_target_group" "elearn-http-target" {
  name              = var.target-grup-name
  port              = var.target-grup-port
  protocol          = var.target-grup-protocol
  vpc_id            = aws_vpc.elearning-VPC.id
  target_type       = var.target-grup-type
  protocol_version  = var.target-grup-protocol-version
  
}


## load balancer listeners for HTTP:80 
resource "aws_lb_listener" "elearn-alb-listener1" {
  load_balancer_arn = aws_lb.elearn-alb.arn
  port              = var.listener-port-1
  protocol          = var.listener-protocol-1 
 
  default_action {
    type             = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


## load balancer listeners for HTTPS:443

#ssl certificate issued
 data "aws_acm_certificate" "my-domain-cert" {
  domain = "betheldom-cloud-academy.click"
  statuses = ["ISSUED"]
 }


resource "aws_lb_listener" "elearn-alb-listener2" {
  load_balancer_arn = aws_lb.elearn-alb.arn
  port              = var.listener-port-2
  protocol          = var.listener-protocol-2
  certificate_arn   = data.aws_acm_certificate.my-domain-cert.arn

  default_action {
    type             =   "forward"                                          # Type of routing action: forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc
    target_group_arn = aws_lb_target_group.elearn-http-target.arn
  }
}

