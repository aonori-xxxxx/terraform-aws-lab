#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Global Accelerator
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_globalaccelerator_accelerator" "stg" {
  name    = var.name_prefix
  enabled = true
  ip_address_type = "IPV4" 
}

resource "aws_globalaccelerator_listener" "stg" {
  accelerator_arn = aws_globalaccelerator_accelerator.stg.id
  protocol        = "TCP"
  port_range {
    from_port = 443
    to_port   = 443
  }
}
