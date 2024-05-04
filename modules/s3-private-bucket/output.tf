
output "bucket_name" {
  value = aws_s3_bucket.private_bucket.bucket
}

output "read_only_policy_arn" {
  value = aws_iam_policy.s3_read_only_access.arn
}

output "read_write_policy_arn" {
  value = aws_iam_policy.s3_read_write_access.arn
}
