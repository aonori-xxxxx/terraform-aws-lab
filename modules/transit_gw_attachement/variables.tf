#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_prefix" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
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
#Transit Gateway
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

variable "tgw_id" {
  type = string
}