#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Transit Gateway 
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# TGWの作成
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_ec2_transit_gateway" "tgw" {
  description = "${var.name_prefix}-tgw"
  tags = {
    Name = "${var.name_prefix}-tgw"
  }
}