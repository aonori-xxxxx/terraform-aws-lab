#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route table
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_route_table" "route_tables" {
  for_each = var.route_tables_mng
  vpc_id   = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-${each.value.name_suffix}"
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route table association
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

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

#RDS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_route_table_association" "internal_rds_rt" {
  for_each = {
    subneta = var.subnet_ids_output["subnet_private_rds_a"]
    subnetc = var.subnet_ids_output["subnet_private_rds_c"]
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.route_tables["rds"].id
}

#Management Server
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_route_table_association" "application_rt_a" {
  for_each = {
    subneta = var.subnet_ids_output["subnet_private_srv_a"]
  }
  route_table_id = aws_route_table.route_tables["mg_a"].id
  subnet_id      = each.value
}

resource "aws_route_table_association" "application_rt_c" {
  for_each = {
    subneta = var.subnet_ids_output["subnet_private_srv_c"]
  }
  route_table_id = aws_route_table.route_tables["mg_c"].id
  subnet_id      = each.value
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
locals {
  routes = {
    #NatGateway
    "nat_gw_rt_route" = { table = "nat_gw", route = var.route_input["route_default"], type = "gateway", id = var.igw_id }
    #RDS
    "rds_rt_tokyo_office_route" = { table = "rds", route = var.route_input["route_tokyo_office"], type = "gateway", id = var.vpn_gw_id }
    "rds_rt_tk_route"           = { table = "rds", route = var.route_input["route_tk"], type = "tgw", id = var.tgw_id }
    "rds_rt_os_route"           = { table = "rds", route = var.route_input["route_os"], type = "tgw", id = var.tgw_id }
    #管理サーバ1a
    "mg_a_rt_tokyo_office_route" = { table = "mg_a", route = var.route_input["route_tokyo_office"], type = "gateway", id = var.vpn_gw_id }
    "mg_a_rt_os_route"           = { table = "mg_a", route = var.route_input["route_os"], type = "tgw", id = var.tgw_id }
    "mg_a_rt_tk_route"           = { table = "mg_a", route = var.route_input["route_tk"], type = "tgw", id = var.tgw_id }
    "mg_a_rt_admin_route"        = { table = "mg_a", route = var.route_input["route_admin"], type = "gateway", id = var.vpn_gw_id }
    "mg_a_rt_default_route"      = { table = "mg_a", route = var.route_input["route_default"], type = "nat", id = var.nat_gw_a_id }
    #管理サーバ1c
    "mg_c_rt_tokyo_office_route" = { table = "mg_c", route = var.route_input["route_tokyo_office"], type = "gateway", id = var.vpn_gw_id }
    "mg_c_rt_os_route"           = { table = "mg_c", route = var.route_input["route_os"], type = "tgw", id = var.tgw_id }
    "mg_c_rt_tk_route"           = { table = "mg_c", route = var.route_input["route_tk"], type = "tgw", id = var.tgw_id }
    "mg_c_rt_admin_route"        = { table = "mg_c", route = var.route_input["route_admin"], type = "gateway", id = var.vpn_gw_id }
    "mg_c_rt_default_route"      = { table = "mg_c", route = var.route_input["route_default"], type = "nat", id = var.nat_gw_c_id }
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
