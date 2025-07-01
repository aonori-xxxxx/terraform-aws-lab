#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#ACMモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "acm" {
  source         = "../../modules/acm"
  year           = var.year  
  ssl_wild       = var.ssl_wild
  ssl_ap         = var.ssl_ap
  ssl_pd         = var.ssl_pd
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
#APIGatewayモジュール ap_A apply
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "api_gateway_tokyo_ap_A_apply" {
  source                  = "../../modules/api_gw"
  name_prefix             = var.name_prefix
  ENV                     = "tokyo-ap-A"
  MODE                    = "apply"
  aws_lambda_function_arn = module.lambda_tokyo_ap_A_apply.aws_lambda_function_arn
  log_group_arn           = module.api_gateway_tokyo_ap_A_apply.log_group_arn
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#APIGatewayモジュール ap_A destroy
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "api_gateway_tokyo_ap_A_destroy" {
  source                  = "../../modules/api_gw"
  name_prefix             = var.name_prefix
  ENV                     = "tokyo-ap-A"
  MODE                    = "destroy"
  aws_lambda_function_arn = module.lambda_tokyo_ap_A_destroy.aws_lambda_function_arn
  log_group_arn           = module.api_gateway_tokyo_ap_A_destroy.log_group_arn
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#APIGatewayモジュール ap_B apply
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "api_gateway_tokyo_ap_B_apply" {
  source                  = "../../modules/api_gw"
  name_prefix             = var.name_prefix
  ENV                     = "tokyo-ap-B"
  MODE                    = "apply"
  aws_lambda_function_arn = module.lambda_tokyo_ap_B_apply.aws_lambda_function_arn
  log_group_arn           = module.api_gateway_tokyo_ap_B_apply.log_group_arn
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#APIGatewayモジュール ap_B destroy
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "api_gateway_tokyo_ap_B_destroy" {
  source                  = "../../modules/api_gw"
  name_prefix             = var.name_prefix
  ENV                     = "tokyo-ap-B"
  MODE                    = "destroy"
  aws_lambda_function_arn = module.lambda_tokyo_ap_B_destroy.aws_lambda_function_arn
  log_group_arn           = module.api_gateway_tokyo_ap_B_destroy.log_group_arn
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Lambdaモジュール tokyo_ap_A apply
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "lambda_tokyo_ap_A_apply" {
  source          = "../../modules/lambda"
  name_prefix     = var.name_prefix
  lambda_role_arn = module.iam.lambda_role_arn
  ENV             = "tokyo-ap-A"
  region          = var.region
  MODE            = "apply"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Lambdaモジュール tokyo_ap_B apply
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "lambda_tokyo_ap_B_apply" {
  source          = "../../modules/lambda"
  name_prefix     = var.name_prefix
  lambda_role_arn = module.iam.lambda_role_arn
  ENV             = "tokyo-ap-B"
  region          = var.region
  MODE            = "apply"
}


#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Lambdaモジュール tokyo_ap_A destroy 
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "lambda_tokyo_ap_A_destroy" {
  source          = "../../modules/lambda"
  name_prefix     = var.name_prefix
  lambda_role_arn = module.iam.lambda_role_arn
  ENV             = "tokyo-ap-A"
  region          = var.region
  MODE            = "destroy"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Lambdaモジュール tokyo_ap_B destroy 
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "lambda_tokyo_ap_B_destroy" {
  source          = "../../modules/lambda"
  name_prefix     = var.name_prefix
  lambda_role_arn = module.iam.lambda_role_arn
  ENV             = "tokyo-ap-B"
  region          = var.region
  MODE            = "destroy"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#CodeBuildモジュール apply tokyo_ap_A
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "codebuild_tokyo_ap_A_apply" {
  source             = "../../modules/codebuild"
  name_prefix        = var.name_prefix
  codebuild_role_arn = module.iam.codebuild_role_arn
  ENV                = "tokyo-ap-A"
  MODE               = "apply"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#CodeBuildモジュール destroy tokyo_ap_A
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "codebuild_tokyo_ap_A_destroy" {
  source             = "../../modules/codebuild"
  name_prefix        = var.name_prefix
  codebuild_role_arn = module.iam.codebuild_role_arn
  ENV                = "tokyo-ap-A"
  MODE               = "destroy"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#CodeBuildモジュール apply tokyo_ap_B
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "codebuild_tokyo_ap_B_apply" {
  source             = "../../modules/codebuild"
  name_prefix        = var.name_prefix
  codebuild_role_arn = module.iam.codebuild_role_arn
  ENV                = "tokyo-ap-B"
  MODE               = "apply"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#CodeBuildモジュール destroy tokyo_ap_B
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "codebuild_tokyo_ap_B_destroy" {
  source             = "../../modules/codebuild"
  name_prefix        = var.name_prefix
  codebuild_role_arn = module.iam.codebuild_role_arn
  ENV                = "tokyo-ap-B"
  MODE               = "destroy"
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
