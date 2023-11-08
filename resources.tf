# 1. Create a VPC (Virtual Private Cloud)
resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block # Define the CIDR block for the VPC (IP range)

  tags = {
    Name = "${var.project_name}-vpc" # Set a tag for the VPC with the project name
  }
}


module "myapp-public-subnet-1" {
  source = "./modules/subnet"
  public_subnet_1_cidr_block = var.public_subnet_1_cidr_block
  public_subnet_1_avail_zone = var.public_subnet_1_avail_zone
  project_name = var.project_name
  vpc_id = aws_vpc.myapp-vpc.id
}


module "myapp-ec2" {
  source = "./modules/ec2"
  project_name = var.project_name
  vpc_id = aws_vpc.myapp-vpc.id
  instance_type = var.instance_type
  ec2_key_name = var.ec2_key_name
  subnet_id = module.myapp-public-subnet-1.subnet.id
}




