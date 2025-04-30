provider "aws" {
  region = "us-east-1"
}

# This is a mock VPC and subnet for testing
# In a real test, you would use the outputs from the VPC module
resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-vpc"
  }
}

resource "aws_subnet" "test_private_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "test-private-subnet"
  }
}

module "ec2_test" {
  source = "../modules/ec2"

  project_name      = "test-ec2"
  private_subnet_id = aws_subnet.test_private_subnet.id
  vpc_id            = aws_vpc.test_vpc.id
  instance_type     = "t2.micro"
  ami_id            = "ami-0c55b159cbfafe1f0"  # This is an example AMI ID
  key_name          = "test-key"
}

output "instance_id" {
  value = module.ec2_test.instance_id
}

output "private_ip" {
  value = module.ec2_test.private_ip
}