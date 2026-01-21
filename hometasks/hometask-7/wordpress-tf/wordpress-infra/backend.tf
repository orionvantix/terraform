terraform {
  backend "s3" {
    bucket  = "terraform-hw-3-bucket"
    key     = "hometask-7/_env_/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

