#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_prefix" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネット
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_ids" {
  type = map(string)

}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#ターゲットグループ
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "target_group_lb1_arn" {
  type = string
}
variable "target_group_pd1_arn" {
  type = string
  
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#起動テンプレート
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

variable "lt-1_id" {
  type = string
}

