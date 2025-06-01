resource "aws_s3_bucket" "aws_identity_behavior_poc_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Project     = "aws-identity-behavior-poc"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.aws_identity_behavior_poc_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.aws_identity_behavior_poc_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_glue_catalog_database" "crm_db" {
  name = var.crm_db_name
}

resource "aws_iam_role" "glue_service_role" {
  name = var.glue_service_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17", # Required fixed version string for trust policy
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com" # Trust AWS Glue
        },
        Action = "sts:AssumeRole" # Let Glue assume the role
      }
    ]
  })
}

#Only allows Glue to assume (use) this role — nothing more.

#It is a trust relationship. It does not define what Glue can do once it has assumed the role.

resource "aws_iam_role_policy_attachment" "glue_policy" {
  role       = aws_iam_role.glue_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy" "s3_access_policy" {
  name = var.s3_access_policy_name
  role = aws_iam_role.glue_service_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::aws-identity-behavior-poc-bucket",
          "arn:aws:s3:::aws-identity-behavior-poc-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_glue_crawler" "crm_idenitifer_crawler" {
  name          = var.crm_idenitifer_crawler_name
  role          = aws_iam_role.glue_service_role.arn
  database_name = aws_glue_catalog_database.crm_db.name

  s3_target {
    path = "s3://aws-identity-behavior-poc-bucket/raw/crm/"
  }

  depends_on = [
    aws_iam_role_policy.s3_access_policy
  ]
}

resource "aws_glue_job" "identity_resolution_job" {
  name     = var.identity_resolution_job_name
  role_arn = aws_iam_role.glue_service_role.arn

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_bucket.aws_identity_behavior_poc_bucket.bucket}/scripts/glue_identity_resolution.py"
    python_version  = "3"
  }

  default_arguments = {
    "--job-language" = "python"
    "--TempDir"      = "s3://${aws_s3_bucket.aws_identity_behavior_poc_bucket.bucket}/temp/"
    "--JOB_NAME"     = "crm-identity-resolution-job"
  }

  glue_version      = "4.0"
  max_retries       = 1
  number_of_workers = 2
  worker_type       = "G.1X"
}
