#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Virtual Private Gateway
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_vpn_gateway" "stg_vp_gw" {
  amazon_side_asn = 64600
  tags = {
    Name = "${var.name_prefix}-vp-gw"
  }
}

resource "aws_vpn_gateway_attachment" "stg" {
  depends_on = [ aws_vpn_gateway.stg_vp_gw ]
  vpn_gateway_id = aws_vpn_gateway.stg_vp_gw.id
  vpc_id         = var.vpc_id
}
