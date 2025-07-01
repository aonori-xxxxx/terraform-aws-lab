
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_prefix" {
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "vpc" {
  type = string
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Availability Zone
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "az_input" {
  type    = map(string)
  default = {}
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネット
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_input" {
  type    = map(string)
  default = {}
}
