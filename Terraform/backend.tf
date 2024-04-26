
terraform {
  backend "s3" {
    bucket = "avirni"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

