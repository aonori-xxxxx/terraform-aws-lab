#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# lambda
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_lambda_function" "app" {
  function_name = "${var.name_prefix}-${var.ENV}"
  role          = var.lambda_role_arn
  runtime       = "python3.12"
  handler       = "function-${var.ENV}.lambda_handler"
  filename         = "../../src/lambda/function-${var.ENV}.zip"
  source_code_hash = filebase64sha256("../../src/lambda/function-${var.ENV}.zip")
}