

terraform {
  backend "s3" {
    bucket     = "ixd-terraform-tfstate-bucket"
    key        = "terraform-nginx-aws-ec2-docker-deployment/terraform.tfstate"
    region     = "us-east-1"
  }
}


provider "aws" {
  #region     = var.aws_region
  #access_key = var.aws_access_key
 # secret_key = var.aws_secret_key
}
