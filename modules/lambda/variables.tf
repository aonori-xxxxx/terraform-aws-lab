#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_prefix" {
  type = string
}
variable "ENV" {
  type = string
}
variable "MODE" {
  type = string
}
variable "region" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#IAM
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "lambda_role_arn" {
  type = string
}
