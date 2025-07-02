#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#RDS パラメータグループ
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_db_parameter_group" "aurora_instance_parametergroup" {
  name   = var.name_prefix
  family = "aurora-mysql8.0"

  dynamic "parameter" {
    for_each = var.rds_parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_instance_parametergroup" {
  name   = "${var.name_prefix}-cluster"
  family = "aurora-mysql8.0"
  dynamic "parameter" {
    for_each = var.rds_parameters_cluster
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", "immediate") # デフォルトを immediate
    }
  }
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#RDS オプショングループ
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_db_option_group" "mysql_optiongroup" {
  name                 = "${var.name_prefix}-optiongroup"
  engine_name          = "aurora-mysql"
  major_engine_version = "8.0"
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#RDS サブネットグループ
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_db_subnet_group" "mysql_standalone_subnetgroup" {
  name = "${var.name_prefix}-rds-subnetgroup"
  subnet_ids = [
    var.subnet_ids_output["subnet_private_rds_a"],
    var.subnet_ids_output["subnet_private_rds_c"],

  ]
  tags = {
    Name = "${var.name_prefix}-rds-subnetgroup"

  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Auroraの作成
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# Aurora クラスターの作成
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier              = "${var.name_prefix}-cluster"
  database_name                   = var.rds_config_cluster["database_name"]
  engine                          = var.rds_config_cluster["engine"]
  engine_version                  = var.rds_config_cluster["engine_version"]
  storage_encrypted               = var.rds_config_cluster["storage_encrypted"]
  preferred_maintenance_window    = var.rds_config_cluster["preferred_maintenance_window"]
  master_username                 = var.rds_config_cluster["master_username"]
  master_password                 = jsondecode(data.aws_secretsmanager_secret_version.db_secret_version.secret_string)["password"]
  backup_retention_period         = var.rds_config_cluster["backup_retention_period"]
  preferred_backup_window         = var.rds_config_cluster["preferred_backup_window"]
  allow_major_version_upgrade     = var.rds_config_cluster["allow_major_version_upgrade"]
  db_subnet_group_name            = aws_db_subnet_group.mysql_standalone_subnetgroup.name
  vpc_security_group_ids          = [var.sg_ids_output["sg_unique_mysql_RDS_id"], var.sg_ids_output["sg_common_mysql_RDS_id"]]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_instance_parametergroup.name
  deletion_protection             = var.rds_config_cluster["deletion_protection"] #削除可設定
  skip_final_snapshot             = var.rds_config_cluster["skip_final_snapshot"] #削除可設定
  apply_immediately               = var.rds_config_cluster["apply_immediately"]   #削除可設定
}

# Aurora インスタンスの作成
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_rds_cluster_instance" "aurora_instance" {
  identifier                            = var.name_prefix
  cluster_identifier                    = aws_rds_cluster.aurora_cluster.id
  instance_class                        = var.rds_config_instance["instance_class"]
  engine                                = var.rds_config_instance["engine"]
  performance_insights_enabled          = var.rds_config_instance["performance_insights_enabled"]
  performance_insights_retention_period = var.rds_config_instance["performance_insights_retention_period"]
  monitoring_interval                   = var.rds_config_instance["monitoring_interval"]
  monitoring_role_arn                   = var.rds_monitoring_role_arn
  auto_minor_version_upgrade            = var.rds_config_instance["auto_minor_version_upgrade"]
  publicly_accessible                   = var.rds_config_instance["publicly_accessible"]
  preferred_maintenance_window          = var.rds_config_instance["preferred_maintenance_window"]
  db_subnet_group_name                  = aws_db_subnet_group.mysql_standalone_subnetgroup.name
  db_parameter_group_name               = aws_db_parameter_group.aurora_instance_parametergroup.name
}

# Secrets Managerの既存シークレットをARNで指定
data "aws_secretsmanager_secret" "db_secret" {
  arn = "arn:aws:secretsmanager:ap-northeast-1:xxxxxx:secret:stg_backlog"
}

# 最新バージョンのシークレット値を取得
data "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}
