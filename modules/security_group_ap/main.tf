#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Security Group
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# ELB
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ELB_external
resource "aws_security_group" "common_web_LBexternal" {
  name   = "${var.name_prefix}-common-web-LBexternal"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-common-web-LBexternal"
  }
}
# ELB_internal
resource "aws_security_group" "common_web_LBinternal" {
  name   = "${var.name_prefix}-common-web-LBinternal"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-common-web-LBinternal"
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

# Maintenance Common
resource "aws_security_group" "common_maint_srv" {
  name   = "${var.name_prefix}-common-maint-srv"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-common-maint-srv"
  }
}

# Maintenance_unique
resource "aws_security_group" "common_app_srv" {
  name   = "${var.name_prefix}-common-app-srv"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-common-app-srv"
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Security Group Rule
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
locals {
  out_rules = {
    "ELB_external"       = { id = aws_security_group.common_web_LBexternal.id, desc = "RDS-specific egress rule" }
    "ELB_internal"       = { id = aws_security_group.common_web_LBinternal.id, desc = "RDS-specific egress rule" }
    "ping"               = { id = aws_security_group.unique_ping_srv.id, desc = "Ping access egress rule" }
    "Maintenance_common" = { id = aws_security_group.common_maint_srv.id, desc = "Unique maintenance access egress rule" }
    "Maintenance_unique" = { id = aws_security_group.common_app_srv.id, desc = "Web access egress rule" }
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

#443
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
locals {
  common_web_LB_in_443_rules = {
    "ELB_external" = { id = aws_security_group.common_web_LBexternal.id, desc = "" }
    "ELB_internal" = { id = aws_security_group.common_web_LBinternal.id, desc = "" }
  }
}
resource "aws_security_group_rule" "common_web_LB_in_443_rules" {
  for_each          = local.common_web_LB_in_443_rules
  security_group_id = each.value.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  description       = each.value.desc
}


#ICMP
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
locals {
  common_ping_in_icmp_rules = {
    "vpc"       = { cidr = var.vpc, desc = "" }
    "vpc_os_ap" = { cidr = var.vpc_mg, desc = "" }
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
    mg_srv_a = { cidr = var.subnet_mg_input["subnet_private_mg_srv_a"], desc = "mg vpc server subnet a" }
    mg_srv_c = { cidr = var.subnet_mg_input["subnet_private_mg_srv_c"], desc = "mg vpc server subnet c" }
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
    mg_srv_a = { cidr = var.subnet_mg_input["subnet_private_mg_srv_a"], desc = "mg vpc server subnet a" }
    mg_srv_c = { cidr = var.subnet_mg_input["subnet_private_mg_srv_c"], desc = "mg vpc server subnet c" }
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
    mg_srv_a = { cidr = var.subnet_mg_input["subnet_private_mg_srv_a"], desc = "mg vpc server subnet a" }
    mg_srv_c = { cidr = var.subnet_mg_input["subnet_private_mg_srv_c"], desc = "mg vpc server subnet c" }
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
    mg_srv_a = { cidr = var.subnet_mg_input["subnet_private_mg_srv_a"], desc = "mg vpc server subnet a" }
    mg_srv_c = { cidr = var.subnet_mg_input["subnet_private_mg_srv_c"], desc = "mg vpc server subnet c" }
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

#8081
locals {
  unique_maint_in_8081_rules = {
    mg_srv_a = { cidr = var.subnet_mg_input["subnet_private_mg_srv_a"], desc = "mg vpc server subnet a" }
    mg_srv_c = { cidr = var.subnet_mg_input["subnet_private_mg_srv_c"], desc = "mg vpc server subnet c" }
  }
}
resource "aws_security_group_rule" "unique_srv_in_8081_rules" {
  for_each          = local.unique_maint_in_8081_rules
  security_group_id = aws_security_group.common_maint_srv.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8081
  to_port           = 8081
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc

}
#8888
locals {
  unique_maint_in_8888_rules = {
    mg_srv_a = { cidr = var.subnet_mg_input["subnet_private_mg_srv_a"], desc = "mg vpc server subnet a" }
    mg_srv_c = { cidr = var.subnet_mg_input["subnet_private_mg_srv_c"], desc = "mg vpc server subnet c" }
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

#App Srv
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#8888
locals {
  common-app-srvin_8888_rules = {
    public_elb_a  = { cidr = var.subnet_input["subnet_public_elb_a"], desc = "public ELB a" }
    public_elb_c  = { cidr = var.subnet_input["subnet_public_elb_c"], desc = "public ELB c" }
    private_elb_a = { cidr = var.subnet_input["subnet_private_elb_a"], desc = "private ELB a" }
    private_elb_c = { cidr = var.subnet_input["subnet_private_elb_c"], desc = "private ELB c" }
  }
}
resource "aws_security_group_rule" "common_app_srv_rules" {
  for_each          = local.common-app-srvin_8888_rules
  security_group_id = aws_security_group.common_app_srv.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8888
  to_port           = 8888
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc

}
