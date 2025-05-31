variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "Environment tag for resources"
  type        = string
}

variable "crm_db_name" {
  description = "Name for glue catalog database"
  type        = string
}

variable "glue_service_role_name" {
  description = "Name of the glue service role"
  type        = string
}

variable "s3_access_policy_name" {
  description = "s3 access policy name"
  type        = string
}

variable "crm_idenitifer_crawler_name" {
  description = "crawler name"
  type        = string
}

variable "identity_resolution_job_name" {
  description = "identity resolution job name"
  type        = string
}
