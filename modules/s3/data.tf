data "aws_iam_policy_document" "s3_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = [
      "arn:aws:s3:::elb-logs-stg",
      "arn:aws:s3:::elb-logs-stg/*"
    ]

    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::555555555555:root",
        "arn:aws:iam::666666666666:root"
      ]
    }
  }
}