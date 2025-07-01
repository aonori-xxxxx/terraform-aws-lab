#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Policy
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#信頼ポリシー
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "rds_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "backup_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}


data "aws_iam_policy_document" "apigateway_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "codebuild_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "eventbridge_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"] 
    }

    actions = ["sts:AssumeRole"]
  }
}



#ポリシー
data "aws_iam_policy_document" "launch_templates" {
  statement {
    sid    = "AllowLaunchTemplateUse"
    effect = "Allow"
    actions = [
      "ec2:*",      
      "autoscaling:*",
      "iam:*"
    ]
    resources = ["*"]  
  }
}


data "aws_iam_policy_document" "api_gateway" {
  statement {
    sid    = "AllowLogAccess"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowEventBridgePutEvents"
    effect = "Allow"

    actions = [
      "events:PutEvents",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "codebuild" {
  statement {
    sid     = "EC2AndVPCFullAccess"
    effect  = "Allow"
    actions = [
      "ec2:*"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "AutoScalingFullAccess"
    effect  = "Allow"
    actions = [
      "autoscaling:*",
      
      "ec2:*"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "ELBFullAccess"
    effect  = "Allow"
    actions = [
      "elasticloadbalancing:*"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "CloudWatchFullAccess"
    effect  = "Allow"
    actions = [
      "cloudwatch:*",
      "logs:*",
      "events:*"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "RunInstancesAccess"
    effect  = "Allow"
    actions = [
      "ec2:RunInstances"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "SecretsManagerFullAccess"
    effect  = "Allow"
    actions = [
      "secretsmanager:*"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "ApiGatewayV2Access"
    effect  = "Allow"
    actions = [
      "apigateway:*"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "S3FullAccess"
    effect  = "Allow"
    actions = [
      "s3:*"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "LaunchTemplateFullAccess"
    effect  = "Allow"
    actions = [
      "ec2:*"
    ]
    resources = ["*"]
  }
}

## EventBridge
data "aws_iam_policy_document" "eventbridge" {
  statement {
    effect = "Allow"
    actions = ["codebuild:*"]
    resources = ["*"]
  }
}

## Lambda
data "aws_iam_policy_document" "lambda" {
  statement {
    effect = "Allow"
    actions = ["lambda:InvokeFunction"]
    resources = ["*"]
  }
}