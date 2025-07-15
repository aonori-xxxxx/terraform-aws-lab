#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#ACMモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "acm" {
  source   = "../../modules/acm"
  year     = var.year
  ssl_wild = var.ssl_wild
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Key Pairモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "keypair" {
  source      = "../../modules/keypair"
  name_prefix = var.name_prefix
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#S3モジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "s3" {
  source          = "../../modules/s3"
  name_elb_bucket = var.name_elb_bucket
  ENV             = "tk"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SNSモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "sns" {
  source        = "../../modules/sns"
  sns_emergency = var.sns_emergency
  sns_error     = var.sns_error
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Transit Gatewayモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "transit_gw" {
  source      = "../../modules/transit_gw"
  name_prefix = var.name_prefix
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#APIGatewayモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "api_gateway_tokyo" {
  source                  = "../../modules/api_gw"
  name_prefix             = var.name_prefix
  ENV                     = "tokyo"
  aws_lambda_function_arn = module.lambda_tokyo_ap.aws_lambda_function_arn
  log_group_arn           = module.api_gateway_tokyo.log_group_arn
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Lambdaモジュール tokyo
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "lambda_tokyo_ap" {
  source          = "../../modules/lambda"
  name_prefix     = var.name_prefix
  lambda_role_arn = module.iam.lambda_role_arn
  ENV             = "tokyo"
  region          = var.region
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#CodeBuildモジュール common
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "codebuild_tokyo_common" {
  source             = "../../modules/codebuild"
  name_prefix        = var.name_prefix
  codebuild_role_arn = module.iam.codebuild_role_arn
  ENV                = "common"
  MODE               = "apply"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#CodeBuildモジュール tokyo_ap_A
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "codebuild_tokyo_ap_A" {
  source             = "../../modules/codebuild"
  name_prefix        = var.name_prefix
  codebuild_role_arn = module.iam.codebuild_role_arn
  ENV                = "tokyo-ap-A"
  MODE               = "apply"
  # MODE               = "destroy"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#CodeBuildモジュール tokyo_ap_B
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "codebuild_tokyo_ap_B" {
  source             = "../../modules/codebuild"
  name_prefix        = var.name_prefix
  codebuild_role_arn = module.iam.codebuild_role_arn
  ENV                = "tokyo-ap-B"
  MODE               = "apply"
  # MODE               = "destroy"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#CodeBuildモジュール Switch Over
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "codebuild_switch_over" {
  source             = "../../modules/codebuild"
  name_prefix        = var.name_prefix
  codebuild_role_arn = module.iam.codebuild_role_arn
  ENV                = "switch-over"
  MODE               = "apply"

}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Direct Connectモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "direct_connect" {
  source      = "../../modules/direct_connect"
  name_prefix = var.name_prefix
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Global Accelerator
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "accelerator" {
  source      = "../../modules/accelerator"
  name_prefix = var.name_prefix
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# IAMモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "iam" {
  source      = "../../modules/iam"
  name_prefix = var.name_prefix
}
