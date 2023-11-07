# Terraform AWS Infrastructure Deployment

This Terraform project automates the deployment of AWS infrastructure components including VPC, Subnets, Internet Gateway, Route Table, Security Group, and EC2 instance. It allows you to set up a basic AWS environment for your application.

## Prerequisites

Before you begin, ensure you have the following:

- AWS Account: You need an AWS account to create the resources. If you don't have one, you can create it [here](https://aws.amazon.com/).
- AWS Credentials: Set up your AWS credentials (access key, secret key) with appropriate permissions.
- Terraform Installed: Make sure you have Terraform installed. You can download it from [terraform.io](https://www.terraform.io/downloads.html).

## Configuration

1. Clone this repository:

   ```bash
   git clone <repository-url>
   cd terraform-nginx-aws-ec2-docker-deployment
   ```

2. Create a `terraform.tfvars` file and provide values for the required variables:

   ```hcl
   aws_region            = "<your-aws-region>"    # AWS region where the infrastructure will be deployed
   aws_access_key        = "<your-access-key>"    # AWS access key for authentication
   aws_secret_key        = "<your-secret-key>"     # AWS secret key for authentication
   project_name          = "<your-project-name>"    # Name of the project; append environment (dev, stag, or prod) later
   vpc_cidr_block        = "10.0.0.0/16"    # CIDR block for the Virtual Private Cloud (VPC)
   public_subnet_1_cidr_block = "10.0.1.0/24"    # CIDR block for the public subnet 1 within the VPC
   public_subnet_1_avail_zone = "<availability-zone>"    # Availability zone for the public subnet 1
   instance_type         = "t2.micro"    # Define the instance type (e.g., t2.micro, m5.large)
   ec2_key_name          = "my-key-pair"    # Name of the manually created key pair for SSH access
   ```

3. Initialize Terraform and apply the configuration:

   ```bash
   terraform init
   terraform apply
   ```

## Usage

After the configuration is applied successfully, you can access the public IP of the created EC2 instance. The public IP address will be displayed as an output after Terraform applies the configuration.

Example Output:

```plaintext
ec2_public_ip = "X.X.X.X"
```

SSH into the EC2 instance using the provided public IP address and the specified key pair.

```bash
ssh -i /path/to/your-key.pem ec2-user@X.X.X.X
```

## Cleanup

To avoid incurring charges, make sure to destroy the created resources after use:

```bash
terraform destroy
```



