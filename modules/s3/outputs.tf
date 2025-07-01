output "s3_bucket_id" {
  value=aws_s3_bucket.elb_logs.id
}

output "s3_bucket_name" {
  value=aws_s3_bucket.elb_logs.bucket
}