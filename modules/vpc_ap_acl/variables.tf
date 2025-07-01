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
variable "vpc_mg" {
  type = string
}
variable "vpc_id" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネット
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_input" {
  type    = map(string)
  default = {}
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネットID
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_ids_output" {
  type    = map(string)
  default = {}
}
