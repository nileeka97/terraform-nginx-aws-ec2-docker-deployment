module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr_block

  azs             = [var.public_subnet_1_avail_zone]
  public_subnets  = [var.public_subnet_1_cidr_block]
  public_subnet_tags = {Name = "${var.project_name}-subnet-1"}

  tags = {
    Name = "${var.project_name}-vpc" 
  }

}


module "myapp-ec2" {
  source = "./modules/ec2"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  instance_type = var.instance_type
  ec2_key_name = var.ec2_key_name
  subnet_id = module.vpc.public_subnets[0]
}




