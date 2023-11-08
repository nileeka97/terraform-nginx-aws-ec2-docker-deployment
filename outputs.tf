# Outputs
# Define output variables to expose specific information about the created resources
output "ec2_public_ip" {
  value = aws_instance.myapp-ec2.public_ip # Output the public IP address of the EC2 instance
}