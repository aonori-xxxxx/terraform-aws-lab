#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ACM 
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_acm_certificate" "wild_cert" {
  private_key       = file("../../src/wild/${var.ssl_wild}.key")
  certificate_body  = file("../../src/wild/${var.ssl_wild}.cer")
  certificate_chain = file("../../src/wild/sample.cer")
  tags = {
    Name = "${var.year}.${var.ssl_wild}"
  }
}
