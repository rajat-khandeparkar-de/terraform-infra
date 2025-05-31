output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.aws_identity_behavior_poc_bucket.id
}
