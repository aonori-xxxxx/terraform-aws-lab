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
variable "vpc" {
  type = string
}
variable "vpc_tk_ap" {
  type = string
}
variable "vpc_os_ap" {
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

# #サブネット 東京リージョン 管理用
variable "subnet_input" {
  type    = map(string)
  default = {}
}
# #東京リージョン AP用
# #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

variable "subnet_tk_input" {
  type    = map(string)
  default = {}
}
# #サブネット 大阪リージョン AP用
# #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
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

#admin
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_admin" {
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
#Route tables
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "route_tables_mng" {
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
#SSL証明書
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "ssl_pd" {
  type = string
}
variable "ssl_ap" {
  type = string
}
variable "ssl_wild" {
  type = string
}

variable "year" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#RDS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "rds_parameters" {
  type = list(object({
    name  = string
    value = string
  }))
}

variable "rds_parameters_cluster" {
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string)
  }))
}

variable "rds_config_cluster" {
  type = map(any)
}

variable "rds_config_instance" {
  type = map(any)
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Backup
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "backup_input" {
  type    = map(string)
  default = {}
}
