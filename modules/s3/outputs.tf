output "bucket_id" {
  description = "The bucket ID"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "The bucket ARN"
  value       = aws_s3_bucket.this.arn
}