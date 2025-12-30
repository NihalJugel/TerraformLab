terraform {
  backend "s3" {
    bucket = "terraformstate8600"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}