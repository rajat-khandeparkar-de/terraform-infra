resource "aws_s3_bucket" "this" {
    bucket = var.bucket_name

    versioning {
        enabled = true
    }

    tags = merge(
    {
      Name      = var.bucket_name
      CreatedBy = "Terraform"
    },
    var.tags
  )
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}