#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC commonモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "vpc" {
  source       = "../../modules/vpc/"
  name_prefix  = var.name_prefix
  subnet_input = var.subnet_input
  vpc          = var.vpc
  az_input     = var.az_input
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Transit Gateway Attachementモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "transit_gw_ap" {
  source            = "../../modules/transit_gw_attachement"
  name_prefix       = var.name_prefix
  subnet_ids_output = module.vpc.subnet_ids_output
  vpc_id            = module.vpc.vpc_id
  tgw_id            = data.terraform_remote_state.common_os.outputs.tgw_id
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC Route tableモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "vpc_routetable" {
  source            = "../../modules/vpc_routetable_ap"
  vpc               = var.vpc
  name_prefix       = var.name_prefix
  route_input       = var.route_input
  route_tables_ap   = var.route_tables_ap
  igw_id            = module.vpc.igw_id
  subnet_ids_output = module.vpc.subnet_ids_output
  vpc_id            = module.vpc.vpc_id
  nat_gw_a_id       = module.vpc.nat_gw_a_id
  nat_gw_c_id       = module.vpc.nat_gw_c_id
  tgw_id            = data.terraform_remote_state.common_os.outputs.tgw_id
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC ACLモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "acl_ap" {
  source            = "../../modules/vpc_ap_acl"
  name_prefix       = var.name_prefix
  vpc               = var.vpc
  vpc_mg            = var.vpc_mg
  subnet_input      = var.subnet_input
  vpc_id            = module.vpc.vpc_id
  subnet_ids_output = module.vpc.subnet_ids_output

}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Security Groupモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "security_group" {
  source          = "../../modules/security_group_ap"
  name_prefix     = var.name_prefix
  vpc             = var.vpc
  vpc_mg          = var.vpc_mg
  subnet_input    = var.subnet_input
  subnet_mg_input = var.subnet_mg_input
  vpc_id          = module.vpc.vpc_id
}


#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#ELBモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "elb" {
  source            = "../../modules/elb"
  name_prefix       = var.name_prefix
  ssl_policy        = var.ssl_policy
  vpc_id            = module.vpc.vpc_id
  subnet_ids_output = module.vpc.subnet_ids_output
  sg_ids_output     = module.security_group.sg_ids_output
  s3_bucket_id      = data.terraform_remote_state.common_os.outputs.s3_bucket_id
  ssl_output        = data.terraform_remote_state.common_os.outputs.ssl_output
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#AWS Cloud Watchモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "cloud_watch" {
  source                      = "../../modules/cloudwatch"
  name_prefix                 = var.name_prefix
  target_group_lb1_arn        = module.elb.target_group_lb1_arn
  target_group_lb1_arn_suffix = module.elb.target_group_lb1_arn_suffix
  target_group_pd1_arn        = module.elb.target_group_pd1_arn
  target_group_pd1_arn_suffix = module.elb.target_group_pd1_arn_suffix
  alb_lb1_arn                 = module.elb.alb_lb1_arn
  alb_lb1_arn_suffix          = module.elb.alb_lb1_arn_suffix
  alb_pd1_arn                 = module.elb.alb_pd1_arn
  alb_pd1_arn_suffix          = module.elb.alb_pd1_arn_suffix
  sns_error_arn               = data.terraform_remote_state.common_os.outputs.sns_error_arn
  sns_emergency_arn           = data.terraform_remote_state.common_os.outputs.sns_emergency_arn
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Launch Templateモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "launch_template" {
  source           = "../../modules/launch_template"
  name_prefix      = var.name_prefix
  name_lt_1        = var.name_lt_1
  ami_id           = var.ami_id
  subnet_ids       = module.vpc.subnet_ids_output
  sg_ids_output    = module.security_group.sg_ids_output
  ec2_profile_name = data.terraform_remote_state.common.outputs.ec2_profile_name
  keypair_name     = data.terraform_remote_state.common.outputs.keypair_name
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Auto Scaling
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "autoscaling" {
  source               = "../../modules/auto_scaling"
  name_prefix          = var.name_prefix
  target_group_pd1_arn = module.elb.target_group_pd1_arn
  target_group_lb1_arn = module.elb.target_group_lb1_arn
  subnet_ids           = module.vpc.subnet_ids_output
  lt-1_id              = module.launch_template.lt-1_id

}