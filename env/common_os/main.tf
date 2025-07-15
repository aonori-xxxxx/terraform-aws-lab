#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#ACMモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "acm" {
  source         = "../../modules/acm"
  year           = var.year
  ssl_wild       = var.ssl_wild
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
  ENV             = "os"
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
module "api_gateway_osaka_ap_apply" {
  source                  = "../../modules/api_gw"
  name_prefix             = var.name_prefix
  ENV                     = "osaka_ap"
  
  aws_lambda_function_arn = module.lambda_osaka_ap_apply.aws_lambda_function_arn
  log_group_arn           = module.api_gateway_osaka_ap_apply.log_group_arn
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#APIGatewayモジュール ap_A destroy
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "api_gateway_osaka_ap_destroy" {
  source                  = "../../modules/api_gw"
  name_prefix             = var.name_prefix
  ENV                     = "osaka_ap"
  aws_lambda_function_arn = module.lambda_osaka_ap_destroy.aws_lambda_function_arn
  log_group_arn           = module.api_gateway_osaka_ap_destroy.log_group_arn
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Lambdaモジュール osaka_ap_A apply
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "lambda_osaka_ap_apply" {
  source          = "../../modules/lambda"
  name_prefix     = var.name_prefix
  lambda_role_arn = data.terraform_remote_state.common.outputs.lambda_role_arn
  ENV             = "osaka-ap"
  region          = var.region
  MODE            = "apply"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Lambdaモジュール osaka_ap destroy 
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "lambda_osaka_ap_destroy" {
  source          = "../../modules/lambda"
  name_prefix     = var.name_prefix
  lambda_role_arn = data.terraform_remote_state.common.outputs.lambda_role_arn
  ENV             = "osaka-ap"
  region          = var.region
  MODE            = "destroy"
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#CodeBuildモジュール apply osaka_ap
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "codebuild_osaka_ap_apply" {
  source             = "../../modules/codebuild"
  name_prefix        = var.name_prefix
  codebuild_role_arn = data.terraform_remote_state.common.outputs.codebuild_role_arn
  ENV                = "osaka-ap"
  MODE               = "apply"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#CodeBuildモジュール destroy osaka_ap
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "codebuild_osaka_ap_destroy" {
  source             = "../../modules/codebuild"
  name_prefix        = var.name_prefix
  codebuild_role_arn = data.terraform_remote_state.common.outputs.codebuild_role_arn
  ENV                = "osaka-ap"
  MODE               = "destroy"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Transit Gateway Peeringモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "transit_peering" {
  source      = "../../modules/transit_peering"
  name_prefix = var.name_prefix
  tgw_os_id   = module.transit_gw.tgw_id
  tgw_tk_id   = data.terraform_remote_state.common.outputs.tgw_tk_id
}
