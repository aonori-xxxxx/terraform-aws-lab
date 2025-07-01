#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

variable "name_prefix" {
type = string
}

variable "region" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Accelerator
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "ga_listener_id" {
  type = string
}

variable "endpoint_configurations" {
  type = list(object({
    endpoint_id = string
    weight      = number
  }))
  default = []
}

variable "traffice_dial_percentage" {
  type = number
}
 
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#ELB
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "elb_arns" {
  type = list(string)
}