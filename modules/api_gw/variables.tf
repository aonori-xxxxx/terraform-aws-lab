#共通

variable "name_prefix" {
  type = string
}

variable "ENV" {
  type = string

}
variable "aws_lambda_function_arn" {
  type = string
}

variable "log_group_arn" {
  type = string
}
