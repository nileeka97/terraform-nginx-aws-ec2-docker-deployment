# Outputs
# Define output variables to expose specific information about the created resources
output "ec2_instance" {
  value = aws_instance.myapp-ec2 # Output the public IP address of the EC2 instance
}