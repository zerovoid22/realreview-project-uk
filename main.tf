provider "aws" {
  region = "us-east-1"  # Change as needed
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI (for us-east-1)
  instance_type = "t2.micro"

  key_name = "your-keypair-name"  # Replace with your actual EC2 key pair name

  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "MyEC2Instance"
  }
}

resource "aws_security_group" "instance_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

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

data "aws_vpc" "default" {
  default = true
}
