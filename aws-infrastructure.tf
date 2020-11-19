provider "aws" {
  region     = "eu-west-1"
  profile    = "ginohotmail"
}

# AWS EC2 instance hosting expense service api
resource "aws_instance" "expT-server1" {
  ami                       = "ami-0aef57767f5404a3c"
  instance_type             = "t2.micro"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.expT-server1-nic.id
  }

  tags = {
      Name  = "et-server1"
  }

  user_data = <<-EOF
      #!/bin/bash
      sudo apt update -y
      sudo apt install docker.io apache2 docker docker-compose -y
      git clone https://github.com/Higino/expense-tracker.git
      cd expense-tracker/
      sudo systemctl start apache2
      sudo bash -c 'docker -v > /var/www/html/index.html'
      EOF
}
resource "aws_network_interface" "expT-server1-nic" {
  subnet_id       = aws_subnet.expT-production-subnet.id
  security_groups = [aws_security_group.allow_ssh_and_web_traffic.id]
}

# Expense tracker production vpc and subnet
resource "aws_vpc" "expT-production-vpc" {
    cidr_block        = "10.0.0.0/16"
    instance_tenancy  = "default"

    tags = {
          Name = "expTproduction-vpc"
      }
}
resource "aws_subnet" "expT-production-subnet" {
    vpc_id        = aws_vpc.expT-production-vpc.id 
    cidr_block    = "10.0.1.0/24"

    tags = {
        Name = "expT-production-subnet"
    }
}


# 2. Create Internet Gateway
resource "aws_internet_gateway" "expT-internet-gw" {
  vpc_id = aws_vpc.expT-production-vpc.id

  tags = {
    Name = "expT-internet-gw"
  }
}
# 3. Create custom routing table
resource "aws_route_table" "expT-prod-route-table" {
  vpc_id = aws_vpc.expT-production-vpc.id

  route {
    cidr_block = "0.0.0.0/0" #route everything
    gateway_id = aws_internet_gateway.expT-internet-gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.expT-internet-gw.id
  }

  tags = {
    Name = "expT-prod-route-table"
  }
}
# 4. Associate subnet with routing table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.expT-production-subnet.id
  route_table_id = aws_route_table.expT-prod-route-table.id
}

# 5. Create security group allowing port 22, 80 443
resource "aws_security_group" "allow_ssh_and_web_traffic" {
  name        = "allow_ssh_and_web_traffic"
  description = "Allow TLS/HTTP/SSH inbound traffic"
  vpc_id      = aws_vpc.expT-production-vpc.id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH from VPC"
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

  tags = {
    Name = "allow_ssh_and_web_traffic"
  }
}



# Assign an elastic ip to the network interface
resource "aws_eip" "expT-server1-public-ip" {
  network_interface = aws_network_interface.expT-server1-nic.id 
  instance = aws_instance.expT-server1.id
  vpc      = true
  depends_on = [ aws_internet_gateway.expT-internet-gw ]
}
