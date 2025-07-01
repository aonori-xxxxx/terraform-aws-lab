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

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サーバ
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "srv_input" {
  type    = map(string)
  default = {}
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネット
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_tk_input" {
  type    = map(string)
  default = {}
}

#サブネット 大阪リージョン AP用
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#AZ-a
variable "subnet_os_input" {
  type    = map(string)
  default = {}
}


#事務所
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_office_input"  {
  type    = map(string)
  default = {}
}

