terraform {
  backend "s3" {
    bucket  = "terraform-hw-3-bucket"
    key     = "hometasks-3/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

