#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Security Group
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# RDS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# RDS Unique
resource "aws_security_group" "unique_mysql_RDS" {
  name   = "${var.name_prefix}-unique-mysql-RDS"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-unique-mysql-RDS"
  }
}
# RDS common
resource "aws_security_group" "common_mysql_RDS" {
  name   = "${var.name_prefix}-common-mysql-RDS"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-common-mysql-RDS"
  }
}
# EC2
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Ping
resource "aws_security_group" "unique_ping_srv" {
  name   = "${var.name_prefix}-unique-ping-srv"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-unique-ping-srv"
  }
}

# Maintenance_common
resource "aws_security_group" "common_maint_srv" {
  name   = "${var.name_prefix}-common-maint-srv"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-common-maint-srv"
  }
}

# Maintenance_unique
resource "aws_security_group" "unique_maint_srv" {
  name   = "${var.name_prefix}-unique-maint-srv"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-unique-maint-srv"
  }
}
# EFS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# common-efs
resource "aws_security_group" "common_efs_efs" {
  name   = "${var.name_prefix}-common-efs-efs"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-common-efs-efs"
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Security Group Rule
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
locals {
  out_rules = {
    "unique_rds"         = { id = aws_security_group.unique_mysql_RDS.id, desc = "RDS-specific egress rule" }
    "common_rds"         = { id = aws_security_group.common_mysql_RDS.id, desc = "RDS-specific egress rule" }
    "ping"               = { id = aws_security_group.unique_ping_srv.id, desc = "Ping access egress rule" }
    "Maintenance_common" = { id = aws_security_group.common_maint_srv.id, desc = "Unique maintenance access egress rule" }
    "Maintenance_unique" = { id = aws_security_group.unique_maint_srv.id, desc = "Web access egress rule" }
    "common-efs"         = { id = aws_security_group.common_efs_efs.id, desc = "efs access egress rule" }
  }
}
resource "aws_security_group_rule" "out_rules" {
  for_each          = local.out_rules
  security_group_id = each.value.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = each.value.desc
}

#3306
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#unique 3306
locals {
  unique_rds_in_3306_rules = {
    "bastion"      = { cidr = var.srv_input["srv_bastion"], desc = "Bastion" }
    "admin_backup" = { cidr = var.srv_input["srv_backup"], desc = "AWS_admin backup" }
  }
}
resource "aws_security_group_rule" "unique_rds_in_3306_rules" {
  security_group_id = aws_security_group.unique_mysql_RDS.id
  for_each          = local.unique_rds_in_3306_rules
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 3306
  to_port           = 3306
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
}

#common 3306
locals {
  common_rds_in_3306_rules = {
    tokyo_a = { cidr = var.subnet_tk_input["subnet_private_tk_srv_a"], desc = "Tokyo app vpc app server a to MySQL" }
    tokyo_c = { cidr = var.subnet_tk_input["subnet_private_tk_srv_c"], desc = "Tokyo app vpc app server c to MySQL" }
    osaka_a  = { cidr = var.subnet_os_input["subnet_private_os_srv_a"], desc = "Osaka app vpc app server a to MySQL" }
    osaka_c  = { cidr = var.subnet_os_input["subnet_private_os_srv_c"], desc = "Osaka app vpc app server c to MySQL" }
  }
}
resource "aws_security_group_rule" "common_rds_in_3306_rules" {
  for_each          = local.common_rds_in_3306_rules
  security_group_id = aws_security_group.common_mysql_RDS.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 3306
  to_port           = 3306
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
}

#ICMP
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
locals {
  common_ping_in_icmp_rules = {
    "subnet" = { cidr = var.subnet_office_input["subnet"], desc = "" }
    "vpc"         = { cidr = var.vpc, desc = "" }
    "vpc_tk_ap"   = { cidr = var.vpc_tk_ap, desc = "" }
    "vpc_os_ap"   = { cidr = var.vpc_os_ap, desc = "" }
  }
}
resource "aws_security_group_rule" "common_ping_in_icmp_rules" {
  for_each          = local.common_ping_in_icmp_rules
  security_group_id = aws_security_group.unique_ping_srv.id
  type              = "ingress"
  protocol          = "icmp"
  from_port         = 8
  to_port           = 0
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
}

#maintenance
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SSH
locals {
  unique_maint_in_ssh_rules = {
    bastion = { cidr = var.srv_input["srv_bastion"], desc = "bastion" }
  }
}
resource "aws_security_group_rule" "unique_maint_in_ssh_rules" {
  for_each          = local.unique_maint_in_ssh_rules
  security_group_id = aws_security_group.common_maint_srv.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc

}

#10050
locals {
  unique_maint_in_10050_rules = {
    srv_zabbix1 = { cidr = var.srv_input["srv_zabbix1"], desc = "AWS_admin monitoring" }
    srv_zabbix2 = { cidr = var.srv_input["srv_zabbix2"], desc = "AWS_admin monitoring" }
  }
}
resource "aws_security_group_rule" "unique_maint_in_10050_rules" {
  for_each          = local.unique_maint_in_10050_rules
  security_group_id = aws_security_group.common_maint_srv.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 10050
  to_port           = 10050
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
}

#10051
locals {
  unique_maint_in_10051_rules = {
    srv_zabbix1 = { cidr = var.srv_input["srv_zabbix1"], desc = "AWS_admin monitoring" }
    srv_zabbix2 = { cidr = var.srv_input["srv_zabbix2"], desc = "AWS_admin monitoring" }
  }
}
resource "aws_security_group_rule" "unique_maint_in_10051_rules" {
  for_each          = local.unique_maint_in_10051_rules
  security_group_id = aws_security_group.common_maint_srv.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 10051
  to_port           = 10051
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
}


#8080
locals {
  unique_maint_in_8080_rules = {
    bastion = { cidr = var.srv_input["srv_bastion"], desc = "bastion" }
  }
}
resource "aws_security_group_rule" "unique_srv_in_8080_rules" {
  for_each          = local.unique_maint_in_8080_rules
  security_group_id = aws_security_group.common_maint_srv.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8080
  to_port           = 8080
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc

}
#8888
locals {
  unique_maint_in_8888_rules = {
    bastion = { cidr = var.srv_input["srv_bastion"], desc = "bastion" }
  }
}
resource "aws_security_group_rule" "unique_srv_in_8888_rules" {
  for_each          = local.unique_maint_in_8888_rules
  security_group_id = aws_security_group.common_maint_srv.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8888
  to_port           = 8888
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc

}

#EFS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#TCP 2049
locals {
  unique_maint_in_efs_rules = {
    tk_srv_a = { cidr = var.subnet_tk_input["subnet_private_tk_srv_a"], desc = "AP Tokyo AZ-a" }
    tk_srv_c = { cidr = var.subnet_tk_input["subnet_private_tk_srv_c"], desc = "AP Tokyo AZ-c" }
    os_srv_a = { cidr = var.subnet_os_input["subnet_private_os_srv_a"], desc = "AP Osaka AZ-a" }
    os_srv_c = { cidr = var.subnet_os_input["subnet_private_os_srv_c"], desc = "AP Osaka AZ-c" }
  }
}
resource "aws_security_group_rule" "common_efs_tcp_in_2049_rules" {
  for_each          = local.unique_maint_in_efs_rules
  security_group_id = aws_security_group.common_efs_efs.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 2049
  to_port           = 2049
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc

}

#UDP 2049
locals {
  common_efs_udp_in_2049_rules = {
    tk_srv_a = { cidr = var.subnet_tk_input["subnet_private_tk_srv_a"], desc = "AP Tokyo AZ-a" }
    tk_srv_c = { cidr = var.subnet_tk_input["subnet_private_tk_srv_c"], desc = "AP Tokyo AZ-c" }
    os_srv_a = { cidr = var.subnet_os_input["subnet_private_os_srv_a"], desc = "AP Osaka AZ-a" }
    os_srv_c = { cidr = var.subnet_os_input["subnet_private_os_srv_c"], desc = "AP Osaka AZ-c" }
  }
}
resource "aws_security_group_rule" "common_efs_udp_in_2049_rules" {
  for_each          = local.common_efs_udp_in_2049_rules
  security_group_id = aws_security_group.common_efs_efs.id
  type              = "ingress"
  protocol          = "udp"
  from_port         = 2049
  to_port           = 2049
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc

}
