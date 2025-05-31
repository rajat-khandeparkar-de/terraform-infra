# AWS Glue IAM Role Setup (Terraform)

This Terraform configuration creates an IAM Role for AWS Glue with the required trust relationship and policy attachment to enable it to run jobs, crawlers, and workflows securely.

## 📦 What This Includes

- **IAM Role**: Allows AWS Glue to assume the role using `sts:AssumeRole`.
- **Policy Attachment**: Attaches the AWS-managed policy `AWSGlueServiceRole` which grants Glue permissions to:
  - Access the Glue Data Catalog
  - Write logs to CloudWatch
  - Access S3 buckets

🧠 Why jsonencode()?

Terraform HCL (HashiCorp Configuration Language) lets you define data structures like maps and objects.

But AWS IAM requires valid JSON for things like assume_role_policy.

🧩 1. When to use Principal?

Use Principal in a trust policy (like in assume_role_policy) to specify who is allowed to assume or use the role.

🧩 2. When to use Resource?

Use Resource in a permissions policy to specify what resources the policy applies to (like S3 buckets, DynamoDB tables, etc.).