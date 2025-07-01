#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "vpc_id" {
  value = aws_vpc.vpc.id
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Internet Gateway
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "igw_id" {
  value = aws_internet_gateway.igw.id
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Nat Gateway
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "nat_gw_a_id" {
  value = aws_nat_gateway.nat_a.id
}
output "nat_gw_c_id" {
  value = aws_nat_gateway.nat_c.id
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネット
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
output "subnet_ids_output" {
  value = {
    subnet_public_elb_a  = aws_subnet.public_elb_a.id
    subnet_public_nat_a  = aws_subnet.public_nat_a.id
    subnet_private_elb_a = aws_subnet.private_elb_a.id
    subnet_private_rds_a = aws_subnet.private_rds_a.id
    subnet_private_tgw_a = aws_subnet.private_tgw_a.id
    subnet_private_srv_a = aws_subnet.private_srv_a.id
    subnet_public_elb_c  = aws_subnet.public_elb_c.id
    subnet_public_nat_c  = aws_subnet.public_nat_c.id
    subnet_private_elb_c = aws_subnet.private_elb_c.id
    subnet_private_rds_c = aws_subnet.private_rds_c.id
    subnet_private_tgw_c = aws_subnet.private_tgw_c.id
    subnet_private_srv_c = aws_subnet.private_srv_c.id
  }
}
