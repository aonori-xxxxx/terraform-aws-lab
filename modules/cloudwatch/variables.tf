#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_prefix" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#ターゲットグループ
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "target_group_lb1_arn" {
  type = string
}
variable "target_group_lb1_arn_suffix" {
  type = string
}
variable "target_group_pd1_arn" {
  type = string
}
variable "target_group_pd1_arn_suffix" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#ターゲットグループ
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "alb_lb1_arn" {
  type = string
}
variable "alb_lb1_arn_suffix" {
  type = string
}
variable "alb_pd1_arn" {
  type = string
}
variable "alb_pd1_arn_suffix" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SNS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "sns_error_arn" {
  type = string
}
variable "sns_emergency_arn" {
  type = string
}
