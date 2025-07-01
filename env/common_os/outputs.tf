#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ACMモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "ssl_output" {
  value = {
    ssl_wild = module.acm.ssl_output.ssl_wild
    ssl_pd   = module.acm.ssl_output.ssl_pd
    ssl_ap   = module.acm.ssl_output.ssl_ap
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Transit Gatewayモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "tgw_id" {
  value = module.transit_gw.tgw_id
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
#SNSモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "sns_error_arn" {
  value = module.sns.sns_error_arn
}
output "sns_emergency_arn" {
  value = module.sns.sns_emergency_arn
}
