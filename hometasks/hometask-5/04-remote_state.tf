data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "terraform-hw-3-bucket"
    key    = "hometasks-3/terraform.tfstate"
    region = "us-east-1"
  }
}
