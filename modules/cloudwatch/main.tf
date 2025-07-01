#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Cloudwatch Watch
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# lb1
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_cloudwatch_metric_alarm" "alb_target_group_lb1_less_than" {
  alarm_name = "${var.name_prefix}-lb1  - HealthyHostCount - less than threshold"

  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 2
  actions_enabled     = true

  dimensions = {

    LoadBalancer = var.alb_lb1_arn_suffix
    TargetGroup  = var.target_group_lb1_arn_suffix
  }

  alarm_actions = [
    var.sns_error_arn
  ]

  ok_actions = [
    var.sns_error_arn
  ]


  insufficient_data_actions = [
    var.sns_error_arn
  ]
}

## stop!
resource "aws_cloudwatch_metric_alarm" "alb_target_group_lb1_service_stop" {
  alarm_name = "${var.name_prefix}-lb1 - HealthyHostCount - service_stop"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  actions_enabled     = true

  dimensions = {

    LoadBalancer = var.alb_lb1_arn_suffix
    TargetGroup  = var.target_group_lb1_arn_suffix
  }

  alarm_actions = [
    var.sns_emergency_arn
  ]

  # OK時のアクション（例: SNS通知）
  ok_actions = [
    var.sns_emergency_arn
  ]

  # データ不足時のアクション（例: SNS通知）
  insufficient_data_actions = [
    var.sns_emergency_arn
  ]
}

# pd1
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_cloudwatch_metric_alarm" "alb_target_group_pd1_less_than" {
  alarm_name = "${var.name_prefix}-pd1  - HealthyHostCount - less than threshold"

  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 2
  actions_enabled     = true

  dimensions = {

    LoadBalancer = var.alb_pd1_arn_suffix
    TargetGroup  = var.target_group_pd1_arn_suffix
  }

  alarm_actions = [
    var.sns_error_arn
  ]

  ok_actions = [
    var.sns_error_arn
  ]


  insufficient_data_actions = [
    var.sns_error_arn
  ]
}

## stop!
resource "aws_cloudwatch_metric_alarm" "alb_target_group_pd1_service_stop" {
  alarm_name = "${var.name_prefix}-pd1 - HealthyHostCount - service_stop"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  actions_enabled     = true

  dimensions = {

    LoadBalancer = var.alb_pd1_arn_suffix
    TargetGroup  = var.target_group_pd1_arn_suffix
  }

  alarm_actions = [
    var.sns_emergency_arn
  ]

  # OK時のアクション（例: SNS通知）
  ok_actions = [
    var.sns_emergency_arn
  ]

  # データ不足時のアクション（例: SNS通知）
  insufficient_data_actions = [
    var.sns_emergency_arn
  ]
}


