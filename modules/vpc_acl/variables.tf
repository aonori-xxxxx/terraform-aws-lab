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
variable "vpc_tk_ap" {
  type = string
}
variable "vpc_os_ap" {
  type = string
}
variable "vpc_id" {
  type = string
}

#事務所
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_office_input" {
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
