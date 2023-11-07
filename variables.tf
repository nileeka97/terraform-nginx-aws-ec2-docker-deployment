# Define input variables for AWS configuration
variable aws_region {}          # AWS region where the infrastructure will be deployed
variable aws_access_key {}      # AWS access key for authentication
variable aws_secret_key {}      # AWS secret key for authentication

# Define input variables for project-specific configurations
variable project_name {}        # Name of the project; append environment (dev, stag, or prod) later
variable vpc_cidr_block {}      # CIDR block for the Virtual Private Cloud (VPC)
variable public_subnet_1_cidr_block {}    # CIDR block for the public subnet 1 within the VPC
variable public_subnet_1_avail_zone {}    # Availability zone for the public subnet 1
variable instance_type {}       # Instance type for the EC2 instance (e.g., t2.micro, m5.large)
variable ec2_key_name {}        # Name of the manually created key pair for SSH access

# Note: It's important to provide appropriate values for these variables when running Terraform.
# The variables aws_region, aws_access_key, and aws_secret_key should be kept secure and not hardcoded in the Terraform code for security reasons.
# The project_name variable is expected to be provided with the environment appended (e.g., "myproject-dev", "myproject-stag", "myproject-prod").
# The vpc_cidr_block and public_subnet_1_cidr_block variables define the IP address ranges for the VPC and its subnets respectively.
# The public_subnet_1_avail_zone variable specifies the availability zone where the public subnet 1 will be created.
# The instance_type variable specifies the type of EC2 instance that will be launched in the public subnet.
# The ec2_key_name variable should match the name of the manually created key pair used for SSH access to the EC2 instances.
