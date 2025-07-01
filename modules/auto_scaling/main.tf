#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Auto Scaling
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_autoscaling_group" "c1-as21_asg" {
  name             = "${var.name_prefix}21"
  max_size         = 0
  min_size         = 0
  desired_capacity = 0

  health_check_grace_period = 400
  health_check_type         = "ELB"

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupPendingInstances",
    "GroupStandbyCapacity",
    "GroupStandbyInstances",
    "GroupTerminatingCapacity",
    "GroupTerminatingInstances",
    "GroupTotalCapacity",
    "GroupTotalInstances",
    "WarmPoolDesiredCapacity",
    "WarmPoolMinSize",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "WarmPoolWarmedCapacity",
  ]
  
  vpc_zone_identifier =[
    var.subnet_ids["subnet_private_srv_a"],
    var.subnet_ids["subnet_private_srv_c"]
  ]
  target_group_arns = [var.target_group_pd1_arn,var.target_group_lb1_arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = var.lt-1_id
        version            = "$Default"
      }

    }
  }
}

resource "aws_autoscaling_lifecycle_hook" "c1-as21_launch_hook" {
  name                   = "launch-hook"
  autoscaling_group_name = aws_autoscaling_group.c1-as21_asg.name
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_LAUNCHING"
  heartbeat_timeout      = 600
  default_result         = "CONTINUE"
}
resource "aws_autoscaling_lifecycle_hook" "c1-as21_terminate_hook" {
  name                   = "terminated-hook"
  autoscaling_group_name = aws_autoscaling_group.c1-as21_asg.name
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  heartbeat_timeout      = 5400
  default_result         = "CONTINUE"

}
