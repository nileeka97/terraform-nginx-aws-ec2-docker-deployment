# 2. Create Subnets within the VPC
resource "aws_subnet" "myapp-public-subnet-1" {
  vpc_id            = var.vpc_id           # Associate the subnet with the created VPC
  cidr_block        = var.public_subnet_1_cidr_block # Define the CIDR block for the subnet
  availability_zone = var.public_subnet_1_avail_zone # Define the availability zone for the subnet

  tags = {
    Name = "${var.project_name}-public-subnet-1" # Set a tag for the subnet with the project name
  }
}





# 3. Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = var.vpc_id # Attach the Internet Gateway to the created VPC

  tags = {
    Name = "${var.project_name}-igw" # Set a tag for the Internet Gateway with the project name
  }
}





# 4. Create a Custom Route Table and add a route for internet traffic via the Internet Gateway
resource "aws_route_table" "myapp-rtb" {
  vpc_id = var.vpc_id  # Associate the route table with the created VPC

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