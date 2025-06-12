terraform {
  backend "s3" {
    bucket = "example-s3-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"
    encrypt = false
    dynamodb_table = "lock-terrform"
  }
}