output "sns_error_arn" {
  value = aws_sns_topic.error.arn
}

output "sns_emergency_arn" {
  value = aws_sns_topic.emergency.arn
}