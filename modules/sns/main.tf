#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# SNS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_sns_topic" "error" {
  name = "error"
}

resource "aws_sns_topic" "emergency" {
  name = "emergency"
}

resource "aws_sns_topic_subscription" "subscriptions" {
  for_each = {
    error = {
      topic_arn = aws_sns_topic.error.arn
      endpoint  = var.sns_error
    }
    emergency = {
      topic_arn = aws_sns_topic.emergency.arn
      endpoint  = var.sns_emergency
    }
  }

  topic_arn = each.value.topic_arn
  protocol  = "email"
  endpoint  = each.value.endpoint
}
