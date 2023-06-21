
## Cloudwatch metric alarm set to ALB and SNS 
resource "aws_cloudwatch_metric_alarm" "elearn-alb_healthyhosts" {
  alarm_name          = var.alarm-name
  comparison_operator = var.alarm-comparator
  evaluation_periods  = var.alarm-evaluation
  metric_name         = var.alarm-metric-name
  namespace           = var.ecs-metric-namespace   
  period              = var.alarm-period
  statistic           = var.alarm-stats
  threshold           = var.alarm-threshold

  alarm_description   = var.alarm-description
  alarm_actions       = [aws_appautoscaling_policy.ecs-autoscale-policy.arn]
  
  dimensions = {
        TargetGroup  = aws_lb_target_group.elearn-http-target.arn_suffix
        LoadBalancer = aws_lb.elearn-alb.arn_suffix
  }
}
