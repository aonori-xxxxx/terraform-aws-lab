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
variable "vpc_mg" {
  type = string
}

#Availability Zone
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "az_input" {
  type    = map(string)
  default = {}
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネット
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# #サブネット 東京リージョン AP用
variable "subnet_input" {
  type    = map(string)
  default = {}
}
# #東京リージョン 管理用
# #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

variable "subnet_mg_input" {
  type    = map(string)
  default = {}
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SubnetID
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_ids" {
  type    = map(string)
  default = {}
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Route tables
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
#SSL Policy
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "ssl_policy" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#ELB
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "elb_bucket_name" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Launch Template
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_lt_1" {
  type = string
}

variable "ami_id" {
  type = string
}


variable "traffice_dial_percentage" {
  type = number
  default = 100
 
}