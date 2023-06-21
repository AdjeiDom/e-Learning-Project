
## Provides an SNS topic resource

resource "aws_sns_topic" "elearning-topic-1" {
  name                        = var.topic-name  
}

# Provides an SNS topic subscription resource
resource "aws_sns_topic_subscription" "sns-target-users" {
  topic_arn = aws_sns_topic.elearning-topic-1.arn
  protocol  = var.sns-topic-protocol
  endpoint  = var.subscription-endpoint
}



# Define SNS policy
resource "aws_sns_topic_policy" "sns-policy" {
  arn = aws_sns_topic.elearning-topic-1.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudwatch.amazonaws.com"
        }
        Action = [
          "SNS:Publish"
        ]
        Resource = aws_sns_topic.elearning-topic-1.arn
      }
    ]
  })
}
