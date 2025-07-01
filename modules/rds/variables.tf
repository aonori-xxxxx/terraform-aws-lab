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

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Monitoring Arn
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

variable "rds_monitoring_role_arn" {
  type = string
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#RDS Parameters
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
