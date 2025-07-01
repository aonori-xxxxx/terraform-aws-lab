#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# key pair
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_key_pair" "keypair" {
  key_name   = "${var.name_prefix}"
  public_key = file("../../src/key/${var.name_prefix}.pub")
  tags = {
    Name = "${var.name_prefix}"
  }
}