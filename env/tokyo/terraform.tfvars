#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#各モジュールで使う名前
name_prefix = "stg-aws1-tk-mg"

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
vpc       = "10.28.0.0/24"
vpc_tk_ap = "10.20.0.0/24"
vpc_os_ap = "10.24.0.0/24"

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

#東京リージョン管理用
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#AZ-a
subnet_input = {
  subnet_public_elb_a  = "10.28.0.0/28"
  subnet_public_nat_a  = "10.28.0.16/28"
  subnet_private_elb_a = "10.28.0.32/28"
  subnet_private_rds_a = "10.28.0.48/28"
  subnet_private_tgw_a = "10.28.0.64/28"
  subnet_private_srv_a = "10.28.0.96/27"

  #AZ-c
  subnet_public_elb_c  = "10.28.0.128/28"
  subnet_public_nat_c  = "10.28.0.144/28"
  subnet_private_elb_c = "10.28.0.160/28"
  subnet_private_rds_c = "10.28.0.176/28"
  subnet_private_tgw_c = "10.28.0.208/28"
  subnet_private_srv_c = "10.28.0.224/27"
}

#東京リージョン AP用
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# #AZ-a
subnet_tk_input = {
  subnet_public_tk_elb_a  = "10.20.0.0/28"
  subnet_public_tk_nat_a  = "10.20.0.16/28"
  subnet_private_tk_elb_a = "10.20.0.32/28"
  subnet_private_tk_rds_a = "10.20.0.48/28"
  subnet_private_tk_tgw_a = "10.20.0.64/28"
  subnet_private_tk_srv_a = "10.20.0.96/27"

  #AZ-c
  subnet_public_tk_elb_c  = "10.20.0.128/28"
  subnet_public_tk_nat_c  = "10.20.0.144/28"
  subnet_private_tk_elb_c = "10.20.0.160/28"
  subnet_private_tk_rds_c = "10.20.0.176/28"
  subnet_private_tk_tgw_c = "10.20.0.208/28"
  subnet_private_tk_srv_c = "10.20.0.224/27"
}

# #大阪リージョン AP用
# #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# #AZ-a
subnet_os_input = {
  subnet_public_os_elb_a  = "10.24.0.0/28"
  subnet_public_os_nat_a  = "10.24.0.16/28"
  subnet_private_os_elb_a = "10.24.0.32/28"
  subnet_private_os_rds_a = "10.24.0.48/28"
  subnet_private_os_tgw_a = "10.24.0.64/28"
  subnet_private_os_srv_a = "10.24.0.96/27"
  #AZ-c
  subnet_public_os_elb_c  = "10.24.0.128/28"
  subnet_public_os_nat_c  = "10.24.0.144/28"
  subnet_private_os_elb_c = "10.24.0.160/28"
  subnet_private_os_rds_c = "10.24.0.176/28"
  subnet_private_os_tgw_c = "10.24.0.192/28"
  subnet_private_os_srv_c = "10.24.0.224/27"
}

#事務所
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
subnet_office_input = {
  subnet              = "10.129.0.0/21"
  subnet_vpn          = "10.129.4.0/24"
  subnet_tokyo_office = "10.129.5.0/24"
}

#admin
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
subnet_admin = "10.10.0.0/16"

#サーバ
srv_input = {
  srv_bastion = "10.129.4.21/32"
  srv_zabbix1 = "10.10.202.20/32"
  srv_zabbix2 = "10.10.202.50/32"
  srv_backup  = "10.10.202.175/32"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
route_input = {
  route_default        = "0.0.0.0/0"
  route_tk             = "10.20.11.0/24"
  route_os             = "10.24.11.0/24"
  route_tokyo_office   = "10.129.0.0/21"
  route_admin = "10.10.0.0/16"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route table
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
route_tables_mng = {
  nat_gw = {
    name_suffix = "nat_gw_rt"
  },
  rds = {
    name_suffix = "rds_rt"
  },
  mg_a = {
    name_suffix = "srv_a_rt"
  },
  mg_c = {
    name_suffix = "srv_c_rt"
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SSL
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
ssl_pd         = "pd.com"
ssl_ap         = "ap.com"
ssl_wild       = "sample.com"
year           = "2024"



# #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# #SNS
# #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# sns_error = "sample@jp.sample.net"
# sns_arts_emergency = "sample@jp.sample.net"

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#RDS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

rds_parameters = [
  { name = "general_log", value = "1" },
  { name = "aurora_parallel_query", value = "0" },
  { name = "interactive_timeout", value = "86400" },
  { name = "log_bin_trust_function_creators", value = "1" },
  { name = "max_allowed_packet", value = "33554432" },
  { name = "transaction_isolation", value = "READ-COMMITTED" },
  { name = "wait_timeout", value = "86400" }
]

rds_parameters_cluster = [
  { name = "aurora_binlog_replication_max_yield_seconds", value = "0" },
  { name = "aurora_parallel_query", value = "0" },
  { name = "character_set_client", value = "utf8" },
  { name = "character_set_connection", value = "utf8" },
  { name = "character_set_database", value = "utf8" },
  { name = "character_set_filesystem", value = "utf8" },
  { name = "character_set_results", value = "utf8" },
  { name = "character_set_server", value = "utf8" },
  { name = "collation_connection", value = "utf8_bin" },
  { name = "collation_server", value = "utf8_bin" },
  { name = "general_log", value = "1" },
  { name = "interactive_timeout", value = "86400" },
  { name = "log_bin_trust_function_creators", value = "1" },
  { name = "binlog_format", value = "MIXED", apply_method = "pending-reboot" },
  { name = "lower_case_table_names", value = "1", apply_method = "pending-reboot" },
  { name = "server_audit_logging", value = "0" },
  { name = "transaction_isolation", value = "READ-COMMITTED" },
  { name = "wait_timeout", value = "86400" }
]

rds_config_cluster = {
  database_name                = "stg_aws1_c1"
  engine                       = "aurora-mysql"
  engine_version               = "8.0.mysql_aurora.3.08.0"
  storage_encrypted            = true
  preferred_maintenance_window = "Sun:18:00-Sun:18:30"
  master_username              = "admin"
  backup_retention_period      = 5
  preferred_backup_window      = "07:00-09:00"
  allow_major_version_upgrade  = false
  #削除可
  deletion_protection = false
  skip_final_snapshot = true
  apply_immediately   = true
  #削除不可
  # deletion_protection = true
  # skip_final_snapshot = false
  # apply_immediately   = false
}


rds_config_instance = {
  instance_class                        = "db.r5.large"
  engine                                = "aurora-mysql"
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  monitoring_interval                   = 60
  auto_minor_version_upgrade            = false
  publicly_accessible                   = false
  preferred_maintenance_window          = "Sat:18:00-Sat:18:30"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Backup
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
backup_input = {
  backup_aurora_tk_vault        = "stg-aws1-tk-aurora-vault"
  backup_aurora_tk_plan         = "stg-aws1-tk-aurora-plan"
  backup_aurora_tk_rule_name    = "daily-backup"
  backup_aurora_tk_schedule     = "cron(35 7 * * ? *)"
  backup_aurora_tk_start_window = 60
  backup_aurora_os_vault        = "stg-aws1-os-aurora-vault"

}
