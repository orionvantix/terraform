terraform {
  backend "s3" {
    bucket         = "terraform-session-3-bucket"
    key            = "session-3/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}