#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_prefix" {
  type = string
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Backup
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "backup_input" {
  type    = map(string)
  default = {}
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#RDS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "aurora_cluster_arn" {
  type = string
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#IAM Role
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "backup_role_arn" {
  type = string
}
