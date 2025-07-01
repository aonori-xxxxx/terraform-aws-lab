#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# S3 Bucket
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_s3_bucket" "elb_logs" {
  bucket = "${var.name_elb_bucket}-${var.ENV}"

  tags = {
    Environment = "stg"
  }
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# S3 Bucket Policy
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#principalsはIAMモジュールの"aws_iam_policy_document"では定義できないため、S3 bucket policyに記述。
resource "aws_s3_bucket_policy" "elb_log_to_s3" {
  bucket = aws_s3_bucket.elb_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowELBAccess"
        Effect    = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::582318560864:root",
            "arn:aws:iam::383597477331:root"
          ]
        }
        Action    = "s3:*"
        Resource  = [
          "arn:aws:s3:::elb-logs-stg-${var.ENV}",
          "arn:aws:s3:::elb-logs-stg-${var.ENV}/*"
        ]
      }
    ]
  })
}