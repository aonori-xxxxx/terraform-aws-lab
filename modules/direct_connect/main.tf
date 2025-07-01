#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Direct Connect Gateway 
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Direct Connect Gateway 作成
resource "aws_dx_gateway" "stg_env" {
  name            = "${var.name_prefix}-dx-gateway"
  amazon_side_asn = 64600
}