#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_prefix" {
  type = string
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
#S3 Bucket
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_elb_bucket" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SNS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "sns_error" {
  type = string
}
variable "sns_emergency" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ENV
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "ENV" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Region
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "region" {
  type = string
}