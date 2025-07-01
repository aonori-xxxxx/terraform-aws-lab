#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
name_prefix = "stg-aws1-tk-ap-A"

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
vpc    = "10.20.0.0/24"
vpc_mg = "10.28.0.0/24"

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Availability Zone
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
az_input = {
  az_a = "ap-northeast-1a"
  az_c = "ap-northeast-1c"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネット
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#東京リージョンAP用
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#AZ-a
subnet_input = {
  subnet_public_elb_a  = "10.20.0.0/28"
  subnet_public_nat_a  = "10.20.0.16/28"
  subnet_private_elb_a = "10.20.0.32/28"
  subnet_private_rds_a = "10.20.0.48/28"
  subnet_private_tgw_a = "10.20.0.64/28"
  subnet_private_srv_a = "10.20.0.96/27"

  #AZ-c
  subnet_public_elb_c  = "10.20.0.128/28"
  subnet_public_nat_c  = "10.20.0.144/28"
  subnet_private_elb_c = "10.20.0.160/28"
  subnet_private_rds_c = "10.20.0.176/28"
  subnet_private_tgw_c = "10.20.0.208/28"
  subnet_private_srv_c = "10.20.0.224/27"
}

#東京リージョン 管理用
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#AZ-a
subnet_mg_input = {
  subnet_public_mg_elb_a  = "10.28.0.0/28"
  subnet_public_mg_nat_a  = "10.28.0.16/28"
  subnet_private_mg_elb_a = "10.28.0.32/28"
  subnet_private_mg_rds_a = "10.28.0.48/28"
  subnet_private_mg_tgw_a = "10.28.0.64/28"
  subnet_private_mg_srv_a = "10.28.0.96/27"
  #AZ-c
  subnet_public_mg_elb_c  = "10.28.0.128/28"
  subnet_public_mg_nat_c  = "10.28.0.144/28"
  subnet_private_mg_elb_c = "10.28.0.160/28"
  subnet_private_mg_rds_c = "10.28.0.176/28"
  subnet_private_mg_tgw_c = "10.28.0.208/28"
  subnet_private_mg_srv_c = "10.28.0.224/27"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
route_input = {
  route_default = "0.0.0.0/0"
  route_mg      = "10.28.11.0/24"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SSL Policy
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
ssl_policy = "ELBSecurityPolicy-FS-1-2-Res-2019-08"

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#ELB Name
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
elb_bucket_name = "elb-logs-stg"

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route table
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
route_tables_ap = {
  nat_gw = {
    name_suffix = "nat_gw_rt"
  },
  external_elb = {
    name_suffix = "external_elb_rt"
  },
  internal_elb = {
    name_suffix = "internal_elb_rt"
  },
  ap_srv_a = {
    name_suffix = "ap_srv_a_rt"
  },
  ap_srv_c = {
    name_suffix = "ap_srv_c_rt"
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Launch Template
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
name_lt_1 = "c1-as21"
ami_id    = "ami-0525a3bbe44c34cbf"
