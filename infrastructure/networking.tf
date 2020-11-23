

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.expT-prod-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id  = aws_internet_gateway.expT-prod-internet-gateway.id
    }

    tags = {
        Name = "Public route table"
    }
}

resource "aws_security_group" "allow-internal-http" {
    name = "allow-internal-http"
    description = "Allow internal http requests"
    vpc_id = aws_vpc.expT-prod-vpc.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks  = [aws_vpc.expT-prod-vpc.cidr_block ]
    }
}

resource "aws_security_group" "allow-http" {
    name = "allow-http"
    description = "Allow HTTP inboud traffic"
    vpc_id = aws_vpc.expT-prod-vpc.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks  = ["0.0.0.0/0" ]
    }
}

resource "aws_security_group" "allow-internal-mysql" {
    name = "allow-internal-mysql"
    description = "Allow internal MySql requests"
    vpc_id = aws_vpc.expT-prod-vpc.id

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks  = [aws_vpc.expT-prod-vpc.cidr_block ]
    }
}

resource "aws_security_group" "allow-all-outbound" {
    name = "allow-all-outbound-traffic"
    description = "Allow all outbound traffic"
    vpc_id = aws_vpc.expT-prod-vpc.id

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow-ssh" {
    name = "allow-ssh"
    description = "Allow internal ssh to machines"
    vpc_id = aws_vpc.expT-prod-vpc.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks  = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow-internal-postgres" {
    name = "allow-internal-postgres"
    description = "Allow internal postgres requests"
    vpc_id = aws_vpc.expT-prod-vpc.id

    ingress {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_blocks  = [aws_vpc.expT-prod-vpc.cidr_block ]
    }
}
resource "aws_route_table_association" "expT-subnet-public" {
    subnet_id = aws_subnet.expT-public-subnet.id
    route_table_id = aws_route_table.public.id
}

resource "aws_db_subnet_group" "private-db-subnet-group" {
    name        = "db-subnet-group-private"
    subnet_ids  = [aws_subnet.expT-private-subnet-2.id, aws_subnet.expT-private-subnet-1.id]

    tags = {
        Name = "Private DB subnet group"
    }
}

resource "aws_subnet" "expT-public-subnet" {
    availability_zone_id    = "euw1-az1"
    cidr_block              = "10.0.0.0/24"
    vpc_id                  = aws_vpc.expT-prod-vpc.id

    tags = {
        Name = "expT public subnet"
    }
}

resource "aws_subnet" "expT-private-subnet-1" {
    availability_zone_id    = "euw1-az1"
    cidr_block              = "10.0.1.0/24"
    vpc_id                  = aws_vpc.expT-prod-vpc.id

    tags = {
        Name = "expT private subnet in availability zone 1"
    }
}

resource "aws_subnet" "expT-private-subnet-2" {
    availability_zone_id    = "euw1-az3"
    cidr_block              = "10.0.2.0/24"
    vpc_id                  = aws_vpc.expT-prod-vpc.id

    tags = {
        Name = "expT private subnet in availability zone 2"
    }
}

resource "aws_internet_gateway" "expT-prod-internet-gateway" {
    vpc_id = aws_vpc.expT-prod-vpc.id
}

resource "aws_vpc" "expT-prod-vpc" {
    cidr_block  = "10.0.0.0/16"
    enable_dns_hostnames    = true

    tags = {
        Name = "Ecxpense Tracking production VPC"
    }
}