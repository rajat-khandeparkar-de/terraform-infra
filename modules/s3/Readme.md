# S3 Bucket Module

This Terraform module creates and manages an AWS S3 bucket with optional configurations such as versioning, encryption, and bucket policies.

---

## 🚀 Features

- S3 bucket creation
- Optional bucket versioning
- Optional server-side encryption
- Custom tags
- Bucket policy support

---

## 📥 Inputs

| Name               | Type     | Default   | Description                             |
|--------------------|----------|-----------|-----------------------------------------|
| `bucket_name`      | string   | n/a       | Name of the S3 bucket (must be globally unique) |
| `enable_versioning`| bool     | false     | Whether to enable versioning on the bucket |
| `tags`             | map      | `{}`      | A map of tags to assign to the bucket    |

---

## 📤 Outputs

| Name             | Description                          |
|------------------|--------------------------------------|
| `bucket_id`      | The name of the bucket               |
| `bucket_arn`     | The ARN of the bucket                |
| `bucket_region`  | The AWS region where the bucket is created |

---

## 🛠 Usage

```hcl
module "s3_bucket" {
  source           = "../modules/s3"
  bucket_name      = "my-unique-bucket-name"
  enable_versioning = true
  tags = {
    Environment = "dev"
    Owner       = "team-data"
  }
}
