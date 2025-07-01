#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# IAM Role ※assume_role_policy
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#EC2
resource "aws_iam_role" "ec2_iam_role" {
  name               = "${var.name_prefix}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}
#RDS
resource "aws_iam_role" "rds_monitoring" {
  name               = "${var.name_prefix}-rds-role"
  assume_role_policy = data.aws_iam_policy_document.rds_assume_role.json
}
#AWS Backup
resource "aws_iam_role" "backup_role" {
  name               = "${var.name_prefix}-Backup-role"
  assume_role_policy = data.aws_iam_policy_document.backup_assume_role.json
}
#API Gateway
resource "aws_iam_role" "api_gateway_role" {
  name               = "${var.name_prefix}-ApiGateway-role"
  assume_role_policy = data.aws_iam_policy_document.apigateway_assume_role.json
}

#CodeBuild
resource "aws_iam_role" "codebuild_role" {
  name               = "${var.name_prefix}-CodeBuild-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role.json
}

#EventBridge
resource "aws_iam_role" "eventbridge_role" {
  name               = "${var.name_prefix}-EventBridge-role"
  assume_role_policy = data.aws_iam_policy_document.eventbridge_assume_role.json
}

#Lambda
resource "aws_iam_role" "lambda_role" {
  name               = "${var.name_prefix}-Lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# IAM Policy
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_iam_policy" "launch_templates" {
  name   = "LaunchTemplatesPolicy"
  policy = data.aws_iam_policy_document.launch_templates.json
}

resource "aws_iam_policy" "api_gateway" {
  name   = "ApiGatewayPolicy"
  policy = data.aws_iam_policy_document.api_gateway.json
}

resource "aws_iam_policy" "codebuild" {
  name   = "CodeBuildPolicy"
  policy = data.aws_iam_policy_document.codebuild.json
}

resource "aws_iam_policy" "eventbridge" {
  name   = "EventBridgePolicy"
  policy = data.aws_iam_policy_document.eventbridge.json
}

resource "aws_iam_policy" "lambda" {
  name   = "LambdaPolicy"
  policy = data.aws_iam_policy_document.lambda.json
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Instance Profile
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

resource "aws_iam_instance_profile" "ec2_profile" {
  name = aws_iam_role.ec2_iam_role.name
  role = aws_iam_role.ec2_iam_role.name
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# IAM Policy Attachment
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

locals {
  ec2_iam_role = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy",
    "arn:aws:iam::aws:policy/CloudWatchFullAccess",
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ]
}
locals {
  rds_monitoring_role = [
    "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  ]
}
locals {
  backup_role = [
    "arn:aws:iam::aws:policy/AWSKeyManagementServicePowerUser",
    "arn:aws:iam::aws:policy/AWSBackupFullAccess",
    "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  ]
}

resource "aws_iam_role_policy_attachment" "ec2_static" {
  for_each   = toset(local.ec2_iam_role) 
  role       = aws_iam_role.ec2_iam_role.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "ec2_dynamic" {
  role       = aws_iam_role.ec2_iam_role.name
  policy_arn = aws_iam_policy.launch_templates.arn
}

resource "aws_iam_role_policy_attachment" "rds" {
  for_each   = toset(local.rds_monitoring_role)
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "backup" {
  for_each   = toset(local.backup_role)
  role       = aws_iam_role.backup_role.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "api_gateway" {
  role       = aws_iam_role.api_gateway_role.name
  policy_arn = aws_iam_policy.api_gateway.arn
}
resource "aws_iam_role_policy_attachment" "codebuild" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild.arn
}
resource "aws_iam_role_policy_attachment" "eventbridge" {
  role       = aws_iam_role.eventbridge_role.name
  policy_arn = aws_iam_policy.eventbridge.arn
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda.arn
}

resource "aws_iam_role_policy_attachment" "lambda_codebuild_admin_access" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_api_gw_admin_access" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_admin_access" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"

}