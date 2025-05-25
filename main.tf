module "s3_bucket" {
  source      = "./modules/s3"
  bucket_name = "test-terraform-bucket-rajatde042025" # Change this to a unique bucket name
  tags = {
    Environment = "production"
    Owner       = "your-name"
  }
}