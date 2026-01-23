terraform {
  backend "s3" {
    bucket  = "terraform-session-4-backend-bucket"
    key     = "session-8/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}

