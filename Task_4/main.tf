locals {
  aws_credentials = jsondecode(file("account.json"))
}

provider "aws" {
  region     = "us-east-1"
  access_key = local.aws_credentials.access_key
  secret_key = local.aws_credentials.secret_key
}
resource "tls_private_key" "example" {
  algorithm = "RSA"
}

resource "aws_key_pair" "example" {
  key_name   = "KI20_Task4"  
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_instance" "web_instance" {
  ami           = "ami-06aa3f7caf3a30282"
  instance_type = "t2.micro"

  tags = {
    Name = "Task4"
  }

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.example.key_name
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y apache2
              sudo systemctl enable apache2
              sudo systemctl start apache2
              EOF
}
resource "aws_security_group" "web_sg" {
  name        = "KI20"
  description = "Allow HTTP/HTTPS traffic"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
