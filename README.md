# Terraform AWS Infrastructure Deployment

Description of your project goes here. Briefly explain what the project does, its purpose, and any important information. For example, setting up a secure and scalable infrastructure on AWS using Terraform.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Deploying the Infrastructure](#deploying-the-infrastructure)
- [Usage](#usage)
- [Cleanup](#cleanup)
- [Contributing](#contributing)

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- AWS account with appropriate permissions.
- Terraform installed on your local machine. [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).


### Deploying the Infrastructure

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/nileeka97/terraform-nginx-aws-ec2-docker-deployment.git
   ```

2. Create a `terraform.tfvars` file and provide values for the required variables:
  In order to deploy the infrastructure, you need to set the following variables in your `terraform.tfvars` file or provide them as environment variables:

    - `aws_region`: AWS region where the infrastructure will be deployed.
    - `aws_access_key`: Your AWS access key.
    - `aws_secret_key`: Your AWS secret key.
    - `project_name`: Name of your project (append environment: dev, stag, or prod).
    - `vpc_cidr_block`: CIDR block for the Virtual Private Cloud (VPC).
    - `public_subnet_1_cidr_block`: CIDR block for the public subnet 1 within the VPC.
    - `public_subnet_1_avail_zone`: Availability zone for the public subnet 1.
    - `instance_type`: Instance type for the EC2 instance (e.g., t2.micro, m5.large).
    - `ec2_key_name`: Name of the manually created key pair for SSH access.
    
    Example `terraform.tfvars`:
    
    ```hcl
    aws_region = "us-west-2"
    aws_access_key = "your-access-key"
    aws_secret_key = "your-secret-key"
    project_name = "myproject-dev"
    vpc_cidr_block = "10.0.0.0/16"
    public_subnet_1_cidr_block = "10.0.1.0/24"
    public_subnet_1_avail_zone = "us-west-2a"
    instance_type = "t2.micro"
    ec2_key_name = "your-key-pair-name"
    ```

3. Navigate to the project directory:

   ```bash
   cd terraform-nginx-aws-ec2-docker-deployment
   ```

4. Initialize Terraform:

   ```bash
   terraform init
   ```

5. Apply the Terraform configuration:

   ```bash
   terraform apply
   ```

### Usage

After the configuration is applied successfully, you can access the public IP of the created EC2 instance. The public IP address will be displayed as an output after Terraform applies the configuration.

Example Output:

```plaintext
ec2_public_ip = "X.X.X.X"
```

## Cleanup

To destroy the infrastructure and cleanup resources, run:

```bash
terraform destroy
```

## Contributing

Feel free to contribute to this project by [opening an issue](https://github.com/nileeka97/terraform-nginx-aws-ec2-docker-deployment/issues) or creating a pull request.
