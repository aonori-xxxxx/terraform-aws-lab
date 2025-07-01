#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_prefix" {

  type = string
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#VPC
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

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

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#S3
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

variable "s3_bucket_id" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SSL
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

variable "ssl_output" {
  type = map(string)
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SSL Policy
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "ssl_policy" {
  type = string
}
