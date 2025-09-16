provider "aws" {
  region = "ap-southeast-2" # update as per your setup
}

# Create a VPC and subnet (optional, if you don't have one already)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-2a"
}

# Security group allowing SSH
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.main.id
  name   = "allow-ssh"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-020e2d6e7640876e9" # Amazon Linux 2 (update for your region)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Terraform-EC2"
  }
}
