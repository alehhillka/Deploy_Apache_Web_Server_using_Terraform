terraform {
  backend "s3" {
    bucket         = "apacheserver"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "apache"
  }
}
