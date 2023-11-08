# 1. Create a VPC (Virtual Private Cloud)
resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block # Define the CIDR block for the VPC (IP range)

  tags = {
    Name = "${var.project_name}-vpc" # Set a tag for the VPC with the project name
  }
}



# 2. Create Subnets within the VPC
resource "aws_subnet" "myapp-public-subnet-1" {
  vpc_id            = aws_vpc.myapp-vpc.id           # Associate the subnet with the created VPC
  cidr_block        = var.public_subnet_1_cidr_block # Define the CIDR block for the subnet
  availability_zone = var.public_subnet_1_avail_zone # Define the availability zone for the subnet

  tags = {
    Name = "${var.project_name}-public-subnet-1" # Set a tag for the subnet with the project name
  }
}



# 3. Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = aws_vpc.myapp-vpc.id # Attach the Internet Gateway to the created VPC

  tags = {
    Name = "${var.project_name}-igw" # Set a tag for the Internet Gateway with the project name
  }
}




# 4. Create a Custom Route Table and add a route for internet traffic via the Internet Gateway
resource "aws_route_table" "myapp-rtb" {
  vpc_id = aws_vpc.myapp-vpc.id # Associate the route table with the created VPC

  route {
    cidr_block = "0.0.0.0/0"                       # Route all traffic (0.0.0.0/0) via the Internet Gateway
    gateway_id = aws_internet_gateway.myapp-igw.id # Set the target gateway for the route
  }

  tags = {
    Name = "${var.project_name}-rtb" # Set a tag for the route table with the project name
  }
}




# 5. Associate the Custom Route Table with the Subnet
resource "aws_route_table_association" "a-rtb-subnet" {
  subnet_id      = aws_subnet.myapp-public-subnet-1.id # Associate the route table with the specified subnet
  route_table_id = aws_route_table.myapp-rtb.id        # Specify the ID of the route table
}




# 6. Create a Security Group to control inbound and outbound traffic
resource "aws_security_group" "myapp-sg" {
  name        = "myapp-sg"             # Set the name for the security group
  description = "myapp-sg-description" # Set the description for the security group
  vpc_id      = aws_vpc.myapp-vpc.id   # Associate the security group with the created VPC

  ingress {
    description = "SSH" # Allow SSH traffic
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from any IP address
  }

  ingress {
    description = "HTTP" # Allow HTTP traffic
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from any IP address
  }

  egress {
    from_port   = 0 # Allow all outbound traffic
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg" # Set a tag for the security group with the project name
  }
}




# 7. Choose the latest Amazon Machine Image (AMI) for EC2 instance
data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true       # Retrieve the most recent AMI
  owners      = ["amazon"] # AMIs owned by Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Filter AMIs with specific naming pattern
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"] # Filter AMIs with HVM (Hardware Virtual Machine) virtualization type
  }
}




# 8. Create an EC2 Instance with the selected AMI and configuration
resource "aws_instance" "myapp-ec2" {
  ami           = data.aws_ami.latest-amazon-linux-image.id # Use the selected AMI for the EC2 instance
  instance_type = var.instance_type                         # Define the instance type (e.g., t2.micro, m5.large)

  subnet_id              = aws_subnet.myapp-public-subnet-1.id # Associate the instance with the specified subnet
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]    # Attach the security group to the instance

  associate_public_ip_address = true             # Assign a public IP address to the instance
  key_name                    = var.ec2_key_name # Specify the key pair for SSH access

  user_data = file("entry-script.sh") # Provide user data script for instance initialization

  tags = {
    Name = "${var.project_name}-ec2" # Set a tag for the instance with the project name
  }
}





