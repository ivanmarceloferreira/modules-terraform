# Arquivo: modules/aws-vpc/main.tf

resource "aws_vpc" "example_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "example-vpc"
  }
}

# Definindo sub-redes, gateways, etc., seguindo uma abordagem similar.
resource "aws_subnet" "example_subnet" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "aula-03-sb"
  }
}

resource "aws_internet_gateway" "example_gw" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name = "Example-gateway"
  }
}

resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_gw.id
  }

  tags = {
    Name = "Example-route-table"
  }
}

resource "aws_route_table_association" "example_rt_assoc" {
  subnet_id      = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.example_route_table.id
}

resource "aws_security_group" "example_sg" {
  name        = "example_sg"
  description = "Security group Example TF"
  vpc_id      = aws_vpc.example_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Example-sg"
  }
}