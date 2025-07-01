#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC commonモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "vpc" {
  source       = "../../modules/vpc/"
  name_prefix  = var.name_prefix
  vpc          = var.vpc
  subnet_input = var.subnet_input
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
  tgw_id            = data.terraform_remote_state.common.outputs.tgw_tk_id
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Virtual Private Gatewayモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "vpg" {
  source      = "../../modules/vpg"
  name_prefix = var.name_prefix
  vpc_id      = module.vpc.vpc_id
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Security Groupモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "security_group" {
  source              = "../../modules/security_group"
  name_prefix         = var.name_prefix
  vpc                 = var.vpc
  vpc_tk_ap           = var.vpc_tk_ap
  vpc_os_ap           = var.vpc_os_ap
  srv_input           = var.srv_input
  subnet_tk_input     = var.subnet_tk_input
  subnet_os_input     = var.subnet_os_input
  subnet_office_input = var.subnet_office_input
  vpc_id              = module.vpc.vpc_id
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC Route tableモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "vpc_routetable" {
  source            = "../../modules/vpc_routetable"
  vpc               = var.vpc
  vpc_tk_ap         = var.vpc_tk_ap
  vpc_os_ap         = var.vpc_os_ap
  name_prefix       = var.name_prefix
  route_input       = var.route_input
  route_tables_mng  = var.route_tables_mng
  subnet_ids_output = module.vpc.subnet_ids_output
  igw_id            = module.vpc.igw_id
  vpc_id            = module.vpc.vpc_id
  vpn_gw_id         = module.vpg.vpn_gw_id
  nat_gw_a_id       = module.vpc.nat_gw_a_id
  nat_gw_c_id       = module.vpc.nat_gw_c_id
  tgw_id            = data.terraform_remote_state.common.outputs.tgw_tk_id
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC ACLモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "acl_mg" {
  source              = "../../modules/vpc_acl"
  name_prefix         = var.name_prefix
  vpc                 = var.vpc
  vpc_tk_ap           = var.vpc_tk_ap
  vpc_os_ap           = var.vpc_os_ap
  subnet_office_input = var.subnet_office_input
  vpc_id              = module.vpc.vpc_id
  subnet_ids_output   = module.vpc.subnet_ids_output
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#EFSモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "efs" {
  source            = "../../modules/efs"
  name_prefix       = var.name_prefix
  vpc               = var.vpc
  vpc_id            = module.vpc.vpc_id
  subnet_ids_output = module.vpc.subnet_ids_output
  sg_ids_output     = module.security_group.sg_ids_output
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#RDSモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "rds" {
  source                  = "../../modules/rds"
  name_prefix             = var.name_prefix
  vpc                     = var.vpc
  rds_parameters          = var.rds_parameters
  rds_parameters_cluster  = var.rds_parameters_cluster
  rds_config_cluster      = var.rds_config_cluster
  rds_config_instance     = var.rds_config_instance
  subnet_ids_output       = module.vpc.subnet_ids_output
  sg_ids_output           = module.security_group.sg_ids_output
  rds_monitoring_role_arn = data.terraform_remote_state.common.outputs.rds_monitoring_role_arn
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#AWS Backup
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "backup" {
  source             = "../../modules/backup"
  name_prefix        = var.name_prefix
  backup_input       = var.backup_input
  aurora_cluster_arn = module.rds.aurora_cluster_arn
  backup_role_arn         = data.terraform_remote_state.common.outputs.backup_role_arn
}


# 最後に実行するモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC Direct Connect attachmentモジュール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module "direct_connect_attachment" {
  source            = "../../modules/direct_connect_attachment"
  vpn_gw_id         = module.vpg.vpn_gw_id
  aws_dx_gateway_id = data.terraform_remote_state.common.outputs.aws_dx_gateway_id
  depends_on        = [module.vpg]
}
