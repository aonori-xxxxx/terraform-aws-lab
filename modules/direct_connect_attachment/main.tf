# Gateway Association (オプション: VPC との関連付け)
resource "aws_dx_gateway_association" "stg_association" {
  dx_gateway_id         = var.aws_dx_gateway_id
  associated_gateway_id = var.vpn_gw_id
}

