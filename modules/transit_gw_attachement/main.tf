#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Transit Gateway 
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# TGWとの紐付け
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc" {
  transit_gateway_id = var.tgw_id
  vpc_id             = var.vpc_id
  subnet_ids = [
    var.subnet_ids_output["subnet_private_tgw_a"],
    var.subnet_ids_output["subnet_private_tgw_c"]

  ]
  tags = {
    Name = "${var.name_prefix}"
  }
}
