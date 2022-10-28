resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "PS_VPC"
  }
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "PS_SUBNET"
  }
}
resource "aws_security_group" "winsec" {
    name = "ALLOW ALL"
    vpc_id = aws_vpc.main.id
ingress {
    from_port        = 0
    to_port          = 65535
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "igw1"
  }
}
resource "aws_key_pair" "pskey" {
    key_name = "powershell_windows"
    public_key = file("pskey.pem")
  
}
resource "aws_directory_service_directory" "main" {
  name     = "poweshell.example.com"
  password = "Powershell5"

  vpc_settings {
    vpc_id     = aws_vpc.main.id
    subnet_ids = [aws_subnet.main.id]
  }

  tags = {
    Project = "aws_powershell"
  }
}

