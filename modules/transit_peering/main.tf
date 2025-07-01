#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Transit Gateway Peering Attachment
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_ec2_transit_gateway_peering_attachment" "tgw_peering_request" {
  transit_gateway_id      = var.tgw_os_id
  peer_transit_gateway_id = var.tgw_tk_id
  peer_region             = "ap-northeast-1"
  tags = {
    Name = "${var.name_prefix}-tgw-peering"
  }
}


