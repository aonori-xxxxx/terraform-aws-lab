#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# CodeBuild
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_codebuild_project" "stg" {
  name           = "${var.name_prefix}-build-${var.ENV}-${var.MODE}"
  description    = "CodeBuild project for ${var.name_prefix}"
  build_timeout  = 60
  queued_timeout = 60
  service_role   = var.codebuild_role_arn
  source {
    type      = "NO_SOURCE"
    buildspec = file("${path.module}/buildspec.yml")
  }
  environment {
    compute_type    = "BUILD_GENERAL1_MEDIUM"
    image           = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = false
    environment_variable {
      name  = "stg_backlog_git"
      value = "arn:aws:secretsmanager:ap-northeast-1:xxxxxx:secret:stg_backlog"
      type  = "SECRETS_MANAGER"
    }

    environment_variable {
      name  = "ENV"
      value = var.ENV
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "MODE"
      value = var.MODE
      type  = "PLAINTEXT"
    }
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
}
