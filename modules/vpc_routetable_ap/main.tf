#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route table
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_route_table" "route_tables" {
  for_each = var.route_tables_ap
  vpc_id   = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-${each.value.name_suffix}"
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route table association
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#External ELB
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_route_table_association" "external_elb_rt" {
  for_each = {
    subneta = var.subnet_ids_output["subnet_public_elb_a"]
    subnetc = var.subnet_ids_output["subnet_public_elb_c"]
  }
  subnet_id       = each.value
  route_table_id = aws_route_table.route_tables["external_elb"].id
}

#Internal ELB
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_route_table_association" "internal_elb_rt" {
  for_each = {
    subneta = var.subnet_ids_output["subnet_private_elb_a"]
    subnetc = var.subnet_ids_output["subnet_private_elb_c"]
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.route_tables["internal_elb"].id
}

#Nat Gateway
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_route_table_association" "nat_gateway_rt" {
  for_each = {
    subneta = var.subnet_ids_output["subnet_public_nat_a"]
    subnetc = var.subnet_ids_output["subnet_public_nat_c"]
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.route_tables["nat_gw"].id
}



#Application Server
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_route_table_association" "application_rt_a" {
  for_each = {
    subneta = var.subnet_ids_output["subnet_private_srv_a"]
  }
  route_table_id = aws_route_table.route_tables["ap_srv_a"].id
  subnet_id      = each.value
}

resource "aws_route_table_association" "application_rt_c" {
  for_each = {
    subneta = var.subnet_ids_output["subnet_private_srv_c"]
  }
  route_table_id = aws_route_table.route_tables["ap_srv_c"].id
  subnet_id      = each.value
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
locals {
  routes = {
    "nat_gw_rt"                  = { table = "nat_gw", route = var.route_input["route_default"], type = "gateway", id = var.igw_id }
    "external_elb_rt"            = { table = "external_elb", route = var.route_input["route_default"], type = "gateway", id = var.igw_id }
    "internal_elb_rt"            = { table = "internal_elb", route = var.route_input["route_default"], type = "tgw", id = var.tgw_id }    
    "ap_arv_a_rt_mg_route"      = { table = "ap_srv_a", route = var.route_input["route_mg"], type = "tgw", id = var.tgw_id }
    "ap_arv_a_rt_default_route" = { table = "ap_srv_a", route = var.route_input["route_default"], type = "nat", id = var.nat_gw_a_id }
    "ap_arv_c_rt_mg_route"      = { table = "ap_srv_c", route = var.route_input["route_mg"], type = "tgw", id = var.tgw_id }
    "ap_arv_c_rt_default_route" = { table = "ap_srv_c", route = var.route_input["route_default"], type = "nat", id = var.nat_gw_c_id }
  }
}

resource "aws_route" "route" {
  for_each               = local.routes
  route_table_id         = aws_route_table.route_tables[each.value.table].id
  destination_cidr_block = each.value.route
  gateway_id             = each.value.type == "gateway" ? each.value.id : null
  nat_gateway_id         = each.value.type == "nat" ? each.value.id : null
  transit_gateway_id     = each.value.type == "tgw" ? each.value.id : null
}
