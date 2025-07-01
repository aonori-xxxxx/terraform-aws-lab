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

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# CodeBuild
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "codebuild_role_arn" {
  type = string
}
