#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Nat GateWay
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

resource "aws_network_acl_rule" "nat_gw_tcp_reg_rule" {
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

resource "aws_network_acl_rule" "nat_gw_all_vpc_rule" {
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
#External ELB
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# NetWork ACL
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl" "ex_elb" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-ex-elb-acl"
  }
}

# NetWork ACL Rule
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl_rule" "ex_elb_icmp_all_rule" {
  network_acl_id = aws_network_acl.ex_elb.id
  rule_number    = 100
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}

resource "aws_network_acl_rule" "ex_elb_tcp_443_rule" {
  network_acl_id = aws_network_acl.ex_elb.id
  rule_number    = 150
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}
resource "aws_network_acl_rule" "ex_elb_tcp_reg_a_rule" {
  network_acl_id = aws_network_acl.ex_elb.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.subnet_input["subnet_private_srv_a"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "ex_elb_udp_reg_a_rule" {
  network_acl_id = aws_network_acl.ex_elb.id
  rule_number    = 210
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = var.subnet_input["subnet_private_srv_a"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "ex_elb_tcp_reg_c_rule" {
  network_acl_id = aws_network_acl.ex_elb.id
  rule_number    = 220
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.subnet_input["subnet_private_srv_c"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "ex_elb_udp_reg_c_rule" {
  network_acl_id = aws_network_acl.ex_elb.id
  rule_number    = 230
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = var.subnet_input["subnet_private_srv_c"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "ex_elb_out_rule" {
  network_acl_id = aws_network_acl.ex_elb.id
  rule_number    = 999
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Internal ELB
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# NetWork ACL
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl" "in_elb" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-in-elb-acl"
  }
}

# NetWork ACL Rule
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl_rule" "in_elb_icmp_all_rule" {
  network_acl_id = aws_network_acl.in_elb.id
  rule_number    = 100
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}

resource "aws_network_acl_rule" "in_elb_tcp_443_rule" {
  network_acl_id = aws_network_acl.in_elb.id
  rule_number    = 150
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}
resource "aws_network_acl_rule" "in_elb_tcp_reg_a_rule" {
  network_acl_id = aws_network_acl.in_elb.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.subnet_input["subnet_private_srv_a"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "in_elb_udp_reg_a_rule" {
  network_acl_id = aws_network_acl.in_elb.id
  rule_number    = 210
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = var.subnet_input["subnet_private_srv_a"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "in_elb_tcp_reg_c_rule" {
  network_acl_id = aws_network_acl.in_elb.id
  rule_number    = 220
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.subnet_input["subnet_private_srv_c"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "in_elb_udp_reg_c_rule" {
  network_acl_id = aws_network_acl.in_elb.id
  rule_number    = 230
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = var.subnet_input["subnet_private_srv_c"]
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "in_elb_out_rule" {
  network_acl_id = aws_network_acl.in_elb.id
  rule_number    = 999
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Application Server
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# NetWork ACL
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl" "ap_srv_acl" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-ap-srv-acl"
  }
}

# NetWork ACL Rule
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_network_acl_rule" "ap_srv_icmp_all_rule" {
  network_acl_id = aws_network_acl.ap_srv_acl.id
  rule_number    = 100
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}


resource "aws_network_acl_rule" "ap_srv_tcp_reg_rule" {
  network_acl_id = aws_network_acl.ap_srv_acl.id
  rule_number    = 150
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "ap_srv_udp_reg_rule" {
  network_acl_id = aws_network_acl.ap_srv_acl.id
  rule_number    = 160
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "ap_srv_tcp_reg_vpc_rule" {
  network_acl_id = aws_network_acl.ap_srv_acl.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.vpc
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "ap_srv_tcp_reg_vpc_mg_rule" {
  network_acl_id = aws_network_acl.ap_srv_acl.id
  rule_number    = 210
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.vpc_mg
  from_port      = 0
  to_port        = 65535
}
resource "aws_network_acl_rule" "ap_srv_udp_reg_vpc_rule" {
  network_acl_id = aws_network_acl.ap_srv_acl.id
  rule_number    = 220
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = var.vpc_mg
  from_port      = 0
  to_port        = 65535
}

resource "aws_network_acl_rule" "ap_srv_out_rule" {
  network_acl_id = aws_network_acl.ap_srv_acl.id
  rule_number    = 999
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = 0
  icmp_code      = 65535
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

resource "aws_network_acl_association" "ex_elb" {
  for_each = {
    "subnet_public_elb_a" = var.subnet_ids_output["subnet_public_elb_a"],
    "subnet_public_elb_c" = var.subnet_ids_output["subnet_public_elb_c"],
  }

  subnet_id      = each.value
  network_acl_id = aws_network_acl.ex_elb.id
}

resource "aws_network_acl_association" "in_elb" {
  for_each = {
    "subnet_private_elb_a" = var.subnet_ids_output["subnet_private_elb_a"],
    "subnet_private_elb_c" = var.subnet_ids_output["subnet_private_elb_c"],
  }
  subnet_id      = each.value
  network_acl_id = aws_network_acl.in_elb.id
}

resource "aws_network_acl_association" "ap_srv_acl" {
  for_each = {
    "subnet_private_srv_a" = var.subnet_ids_output["subnet_private_srv_a"],
    "subnet_private_srv_c" = var.subnet_ids_output["subnet_private_srv_c"]
  }

  subnet_id      = each.value
  network_acl_id = aws_network_acl.ap_srv_acl.id
}
