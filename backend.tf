terraform {
  required_version = ">= 1.3"

  backend "s3" {
    bucket         = "terraform-state-bucket-rajatde052025"
    key            = "terraform-infraterraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-table-rajatde052025"
  }
}