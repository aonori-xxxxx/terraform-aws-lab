output "rds_monitoring_role_arn" {
  value = aws_iam_role.rds_monitoring.arn
}
output "ec2_iam_role_arn" {
  value = aws_iam_role.ec2_iam_role.arn
}
output "ec2_profile_arn" {
  value = aws_iam_instance_profile.ec2_profile.arn
}
output "ec2_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}
output "backup_role_arn" {
  value = aws_iam_role.backup_role.arn
}
output "api_gateway_role_arn" {
  value = aws_iam_role.api_gateway_role.arn
}
output "codebuild_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}
output "eventbridge_role_arn" {
  value = aws_iam_role.eventbridge_role.arn
}
output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}
