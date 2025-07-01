#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_prefix" {
  type = string
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "vpc" {
  type = string
}

variable "vpc_id" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネット
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_ids_output" {
  type = map(string)
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route Tables
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "route_tables_ap" {
  type = map(object({
    name_suffix = string
  }))
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "route_input" {
  type    = map(string)
  default = {}
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Transit Gateway
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

variable "tgw_id" {
  type = string
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Internet Gateway
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "igw_id" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Nat Gateway
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "nat_gw_a_id" {
  type = string
}
variable "nat_gw_c_id" {
  type = string
}