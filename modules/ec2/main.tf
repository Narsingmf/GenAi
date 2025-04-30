# EC2 Module - main.tf

# Create security group for EC2 instance
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-ec2-sg"
  description = "Security group for EC2 instance in private subnet"
  vpc_id      = var.vpc_id

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH from within VPC (for management)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    description = "SSH access from within VPC"
  }

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}

# Get VPC data for CIDR block
data "aws_vpc" "selected" {
  id = var.vpc_id
}

# Create IAM role for EC2 instance (optional, uncomment if needed)
/*
resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}
*/

# Create EC2 instance in private subnet
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name
  
  # Uncomment if using IAM role
  # iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    encrypted   = true
  }

  tags = {
    Name = "${var.project_name}-ec2-instance"
  }
}