#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ELB ※Application Load Balancer
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# lb1
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_lb" "alb_lb1" {

  name               = "${var.name_prefix}-lb1-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    var.sg_ids_output["sg_common_web_LBexternal_id"]
  ]

  subnets = [
    var.subnet_ids_output["subnet_public_elb_a"],
    var.subnet_ids_output["subnet_public_elb_c"]
  ]
  access_logs {
    bucket  = var.s3_bucket_id
    prefix  = "${var.name_prefix}-lb1-alb"
    enabled = true
  }
  tags = {
    Name = "${var.name_prefix}-lb1-alb"

  }
  enable_deletion_protection = false #一旦これを設定する。
  # enable_deletion_protection = true #削除保護

}

resource "aws_lb_listener" "listener_lb1" {
  load_balancer_arn = aws_lb.alb_lb1.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.ssl_output["ssl_wild"]
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_lb1.arn
  }
}

# pd1
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_lb" "alb_pd1" {
  name               = "${var.name_prefix}-pd1-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    var.sg_ids_output["sg_common_web_LBexternal_id"]
  ]

  subnets = [
    var.subnet_ids_output["subnet_public_elb_a"],
    var.subnet_ids_output["subnet_public_elb_c"]
  ]
  access_logs {
    bucket  = var.s3_bucket_id
    prefix  = "${var.name_prefix}-pd1-alb"
    enabled = true
  }

  enable_deletion_protection = false #一旦これを設定する。
  # enable_deletion_protection = true #削除保護
  tags = {
    Name = "${var.name_prefix}-pd1-alb"

  }
}

resource "aws_lb_listener" "listener_pd1" {
  load_balancer_arn = aws_lb.alb_pd1.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.ssl_output["ssl_pd"]
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_pd1.arn
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Target Group
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# lb1
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_lb_target_group" "target_group_lb1" {

  name     = "${var.name_prefix}-lb1-tg"
  port     = 8888
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  stickiness {
    enabled         = true
    type            = "lb_cookie"
    cookie_duration = 600
  }
  health_check {
    enabled = true
    path    = "/check/checker"
    port    = "8888"
  }
  tags = {
    Name = "${var.name_prefix}-lb1-tg"
  }
}


# pd1
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_lb_target_group" "target_group_pd1" {

  name     = "${var.name_prefix}-pd1-tg"
  port     = 8888
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  stickiness {
    enabled         = true
    type            = "lb_cookie"
    cookie_duration = 600
  }
  health_check {
    enabled = true
    path    = "/check/checker"
    port    = "8888"
  }
  tags = {
    Name = "${var.name_prefix}-pd1-tg"

  }
}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ルール
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# lb1
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_lb_listener_rule" "defRule_lb1" {
  listener_arn = aws_lb_listener.listener_lb1.arn
  priority     = 30
  action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.target_group_lb1.arn
        weight = 100
      }

      stickiness {
        duration = 600
        enabled  = true
      }
    }
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
  tags = {
    Name = "defRule"
  }
}

resource "aws_lb_listener_rule" "maintenance_lb1" {
  listener_arn = aws_lb_listener.listener_lb1.arn
  priority     = 100

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "只今メンテナンス中です。少し待ってから再度お試し下さい。"
      status_code  = "503"
    }
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
  tags = {
    Name = "maintenance"
  }
}

# pd1
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_lb_listener_rule" "defRule_pd1" {
  listener_arn = aws_lb_listener.listener_pd1.arn
  priority     = 30
  action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.target_group_pd1.arn
        weight = 100
      }

      stickiness {
        duration = 600
        enabled  = true
      }
    }
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
  tags = {
    Name = "defRule"
  }
}

resource "aws_lb_listener_rule" "maintenance_pd1" {
  listener_arn = aws_lb_listener.listener_pd1.arn
  priority     = 100

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "只今メンテナンス中です。少し待ってから再度お試し下さい。"
      status_code  = "503"
    }
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
  tags = {
    Name = "maintenance"
  }
}
