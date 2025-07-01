#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネット
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_subnet" "public_elb_a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az_input["az_a"]
  
  cidr_block        = var.subnet_input["subnet_public_elb_a"]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name_prefix}-public-elb-a"
  }
}

resource "aws_subnet" "public_elb_c" {
  vpc_id            = aws_vpc.vpc.id
  
  availability_zone = var.az_input["az_c"]
  cidr_block        = var.subnet_input["subnet_public_elb_c"]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name_prefix}-public-elb-c"
  }
}

resource "aws_subnet" "public_nat_a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az_input["az_a"]
  cidr_block        = var.subnet_input["subnet_public_nat_a"]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name_prefix}-public-nat-a"
  }
}

resource "aws_subnet" "public_nat_c" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az_input["az_c"]
  cidr_block        = var.subnet_input["subnet_public_nat_c"]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name_prefix}-public-nat-c"
  }
}

resource "aws_subnet" "private_elb_a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az_input["az_a"]
  cidr_block = var.subnet_input["subnet_private_elb_a"]
  tags = {
    Name = "${var.name_prefix}-private-elb-a"
  }
}

resource "aws_subnet" "private_elb_c" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az_input["az_c"]
  cidr_block        = var.subnet_input["subnet_private_elb_c"]
  tags = {
    Name = "${var.name_prefix}-private-elb-c"
  }
}

resource "aws_subnet" "private_rds_a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az_input["az_a"]
  cidr_block        = var.subnet_input["subnet_private_rds_a"]
  tags = {
    Name = "${var.name_prefix}-private-rds-a"
  }
}

resource "aws_subnet" "private_rds_c" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az_input["az_c"]
  cidr_block        = var.subnet_input["subnet_private_rds_c"]
  tags = {
    Name = "${var.name_prefix}-private-rds-c"
  }
}

resource "aws_subnet" "private_tgw_a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az_input["az_a"]
  cidr_block = var.subnet_input["subnet_private_tgw_a"]
  tags = {
    Name = "${var.name_prefix}-private-tgw-a"
  }
}

resource "aws_subnet" "private_tgw_c" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az_input["az_c"]
  cidr_block = var.subnet_input["subnet_private_tgw_c"]
  tags = {
    Name = "${var.name_prefix}-private-tgw-c"
  }
}

resource "aws_subnet" "private_srv_a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az_input["az_a"]
  cidr_block = var.subnet_input["subnet_private_srv_a"]
  tags = {
    Name = "${var.name_prefix}-private-srv-a"
  }
}

resource "aws_subnet" "private_srv_c" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az_input["az_c"]
  cidr_block = var.subnet_input["subnet_private_srv_c"]
  tags = {
    Name = "${var.name_prefix}-private-srv-c"
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Internet Gateway
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Elastic IPの作成（NAT Gateway用）
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_eip" "eip_a" {
  domain = "vpc"
  tags = {
    Name = "${var.name_prefix}-eip-a"
  }
}
resource "aws_eip" "eip_c" {
  domain = "vpc"
  tags = {
    Name = "${var.name_prefix}-eip-c"
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Nat Gateway
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.eip_a.id
  subnet_id     = aws_subnet.public_nat_a.id
  tags = {
    Name = "${var.name_prefix}-nat-a"
  }
}

resource "aws_nat_gateway" "nat_c" {
  allocation_id = aws_eip.eip_c.id
  subnet_id     = aws_subnet.public_nat_c.id
  tags = {
    Name = "${var.name_prefix}-nat-c"
  }
}
