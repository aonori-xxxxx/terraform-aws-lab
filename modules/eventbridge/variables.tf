#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

variable "name_prefix" {
  type = string
}
variable "ENV" {
  type = string  
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# CodeBuild
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# variable "codebuild_role_arn" {
#   type = string
# }


variable "codebuild_project_arn"{
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# EventBridge
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "eventbridge_role_arn" {
  type = string
}
