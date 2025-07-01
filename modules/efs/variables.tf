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
#Security Group
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "sg_ids_output" {
  type = map(string)
}
