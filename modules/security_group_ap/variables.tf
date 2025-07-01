#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#タグで使う名前
variable "name_prefix" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "vpc_id" {
  type = string
}
variable "vpc" {
  type = string
}
variable "vpc_mg" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネット
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#東京リージョン AP用
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_input" {
  type    = map(string)
  default = {}
}

#東京リージョン 管理用
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_mg_input" {
  type    = map(string)
  default = {}
}

