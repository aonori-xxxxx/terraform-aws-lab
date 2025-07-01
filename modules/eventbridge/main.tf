#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# EventBridge
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_cloudwatch_event_rule" "stg" {
  name           = "${var.name_prefix}-${var.ENV}"
  description    = "Trigger CodeBuild on Backlog push"
  event_bus_name = aws_cloudwatch_event_bus.custom.name
  event_pattern = jsonencode({
    source      = ["${var.ENV}.event"]
    detail-type = ["manual-trigger"]
    detail = {
      "repository" : {
        "name" : ["terraform_stg_${var.ENV}"]
      }
    }
    }
  )
}


resource "aws_cloudwatch_event_target" "stg" {
  rule           = aws_cloudwatch_event_rule.stg.name
  event_bus_name = aws_cloudwatch_event_bus.custom.name
  target_id      = "CodeBuildProject-${var.ENV}"
  arn            = var.codebuild_project_arn
  role_arn       = var.eventbridge_role_arn
}

resource "aws_cloudwatch_event_bus" "custom" {
  name = "${var.name_prefix}-${var.ENV}-bus"
}
