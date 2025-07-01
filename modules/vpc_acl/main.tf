#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Nat Gateway
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# NetWork ACL
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl" "nat_gw_acl" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-nat-gw-acl"
  }
}

# NetWork ACL Rule
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#acl名_protocol_port_(az or cidr)_rule
resource "aws_network_acl_rule" "nat_gw_icmp_all_rule" {
  network_acl_id = aws_network_acl.nat_gw_acl.id
  rule_number    = 50
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}

resource "aws_network_acl_rule" "nat_tcp_reg_rule" {
  network_acl_id = aws_network_acl.nat_gw_acl.id
  rule_number    = 150
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "nat_gw_udp_reg_rule" {
  network_acl_id = aws_network_acl.nat_gw_acl.id
  rule_number    = 160
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "nat_gw_all_all_rule" {
  network_acl_id = aws_network_acl.nat_gw_acl.id
  rule_number    = 200
  egress         = false
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = var.vpc
  from_port      = -1
  to_port        = -1
}

resource "aws_network_acl_rule" "nat_gw_out_rule" {
  network_acl_id = aws_network_acl.nat_gw_acl.id
  rule_number    = 999
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}


#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#RDS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# NetWork ACL
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl" "rds_acl" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-rds-acl"
  }
}

# NetWork ACL Rule
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl_rule" "rds_icmp_all_rule" {
  network_acl_id = aws_network_acl.rds_acl.id
  rule_number    = 100
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}

resource "aws_network_acl_rule" "rds_all_all_vpc_rule" {
  network_acl_id = aws_network_acl.rds_acl.id
  rule_number    = 200
  egress         = false
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = var.vpc
  from_port      = -1
  to_port        = -1
}

resource "aws_network_acl_rule" "rds_all_all_vpc_tk_rule" {
  network_acl_id = aws_network_acl.rds_acl.id
  rule_number    = 210
  egress         = false
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = var.vpc_tk_ap
  from_port      = -1
  to_port        = -1
}

resource "aws_network_acl_rule" "rds_all_all_vpc_os_rule" {
  network_acl_id = aws_network_acl.rds_acl.id
  rule_number    = 220
  egress         = false
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = var.vpc_os_ap
  from_port      = -1
  to_port        = -1
}
resource "aws_network_acl_rule" "rds_all_all_subnet_vpn_rule" {
  network_acl_id = aws_network_acl.rds_acl.id
  rule_number    = 500
  egress         = false
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = var.subnet_office_input["subnet_vpn"]
  from_port      = -1
  to_port        = -1
}

resource "aws_network_acl_rule" "rds_all_all_subnet_tokyo_office_rule" {
  network_acl_id = aws_network_acl.rds_acl.id
  rule_number    = 510
  egress         = false
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = var.subnet_office_input["subnet_tokyo_office"]
  from_port      = -1
  to_port        = -1
}

resource "aws_network_acl_rule" "rds_out_rule" {
  network_acl_id = aws_network_acl.rds_acl.id
  rule_number    = 999
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Managemnet Server
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# NetWork ACL
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl" "mg_srv_acl" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-mg-srv-acl"
  }
}

# NetWork ACL Rule
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl_rule" "mg_srv_icmp_all_rule" {
  network_acl_id = aws_network_acl.mg_srv_acl.id
  rule_number    = 100
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}


resource "aws_network_acl_rule" "mg_srv_tcp_reg_rule" {
  network_acl_id = aws_network_acl.mg_srv_acl.id
  rule_number    = 150
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "mg_srv_udp_reg_rule" {
  network_acl_id = aws_network_acl.mg_srv_acl.id
  rule_number    = 160
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "mg_srv_tcp_reg_vpc_rule" {
  network_acl_id = aws_network_acl.mg_srv_acl.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.vpc
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "mg_srv_tcp_reg_vpc_tk_rule" {
  network_acl_id = aws_network_acl.mg_srv_acl.id
  rule_number    = 210
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.vpc_tk_ap
  from_port      = 1024
  to_port        = 65535
}
resource "aws_network_acl_rule" "mg_srv_tcp_reg_vpc_os_rule" {
  network_acl_id = aws_network_acl.mg_srv_acl.id
  rule_number    = 220
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.vpc_os_ap
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "mg_srv_tcp_reg_subnet_vpn_rule" {
  network_acl_id = aws_network_acl.mg_srv_acl.id
  rule_number    = 500
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.subnet_office_input["subnet_vpn"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "mg_srv_udp_reg_subnet_vpn_rule" {
  network_acl_id = aws_network_acl.mg_srv_acl.id
  rule_number    = 510
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = var.subnet_office_input["subnet_vpn"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "mg_srv_tcp_reg_subnet_tokyo_office_rule" {
  network_acl_id = aws_network_acl.mg_srv_acl.id
  rule_number    = 520
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.subnet_office_input["subnet_tokyo_office"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "mg_srv_udp_reg_subnet_tokyo_office_rule" {
  network_acl_id = aws_network_acl.mg_srv_acl.id
  rule_number    = 530
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = var.subnet_office_input["subnet_tokyo_office"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "mg_srv_out_rule" {
  network_acl_id = aws_network_acl.mg_srv_acl.id
  rule_number    = 999
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Network ACLとサブネットの関連づけ
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl_association" "nat_gw_acl" {
  for_each = {
    "subnet_public_nat_a" = var.subnet_ids_output["subnet_public_nat_a"],
    "subnet_public_nat_c" = var.subnet_ids_output["subnet_public_nat_c"]
  }
  subnet_id      = each.value
  network_acl_id = aws_network_acl.nat_gw_acl.id
}

resource "aws_network_acl_association" "rds_acl" {
  for_each = {
    "subnet_private_rds_a" = var.subnet_ids_output["subnet_private_rds_a"],
    "subnet_private_rds_c" = var.subnet_ids_output["subnet_private_rds_c"]
  }

  subnet_id      = each.value
  network_acl_id = aws_network_acl.rds_acl.id
}

resource "aws_network_acl_association" "mg_srv_acl" {
  for_each = {
    "subnet_private_srv_a" = var.subnet_ids_output["subnet_private_srv_a"],
    "subnet_private_srv_c" = var.subnet_ids_output["subnet_private_srv_c"]
  }

  subnet_id      = each.value
  network_acl_id = aws_network_acl.mg_srv_acl.id
}
