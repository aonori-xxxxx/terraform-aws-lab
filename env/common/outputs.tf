#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ACMモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "ssl_output" {
  value = {
    ssl_wild       = module.acm.ssl_output.ssl_wild
    ssl_pd         = module.acm.ssl_output.ssl_pd
    ssl_ap         = module.acm.ssl_output.ssl_ap
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# IAMモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "rds_monitoring_role_arn" {
  value = module.iam.rds_monitoring_role_arn
}
output "ec2_iam_role_arn" {
  value = module.iam.ec2_iam_role_arn
}
output "ec2_profile_arn" {
  value = module.iam.ec2_profile_arn
}
output "ec2_profile_name" {
  value = module.iam.ec2_profile_name
}
output "backup_role_arn" {
  value = module.iam.backup_role_arn
}
output "api_gateway_role_arn" {
  value = module.iam.api_gateway_role_arn 
}
output "eventbridge_role_arn" {
  value = module.iam.eventbridge_role_arn
}
output "codebuild_role_arn" {
  value = module.iam.codebuild_role_arn
}
output "lambda_role_arn" {
  value = module.iam.lambda_role_arn
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Key Pairモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "keypair_name" {
  value = module.keypair.keypair_name
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# S3モジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "s3_bucket_id" {
  value = module.s3.s3_bucket_id
}
output "s3_bucket_name" {
  value = module.s3.s3_bucket_name
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Transit Gatewayモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "tgw_tk_id" {
  value = module.transit_gw.tgw_id
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SNSモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "sns_error_arn" {
  value = module.sns.sns_error_arn
}
output "sns_emergency_arn" {
  value = module.sns.sns_emergency_arn
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Direct Connectモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "aws_dx_gateway_id" {
  value = module.direct_connect.aws_dx_gateway_id
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Global Acceleratorモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "ga_listener_id" {
  value = module.accelerator.ga_listener_id
}
