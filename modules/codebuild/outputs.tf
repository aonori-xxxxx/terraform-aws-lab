output "codebuild_project_arn" {
  value = aws_codebuild_project.stg.arn
}

# output "common_codebuild_arn" {
#   value = module.codebuild.codebuild_project_arn
# }

# output "tokyo_codebuild_arn" {
#   value = module.codebuild_tokyo.codebuild_project_arn
# }

