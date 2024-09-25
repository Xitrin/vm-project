terraform {
  backend "s3" {
    bucket = "state-bucket-terra"
    key    = "terraform/ec2-instance/terraform.tfstate"
    region = "us-east-1"
  }
}
