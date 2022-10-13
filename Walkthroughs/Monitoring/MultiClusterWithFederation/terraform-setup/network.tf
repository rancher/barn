resource "aws_vpc" "monitoring_demo_vpc" {
  count                = 3
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "monitoring-demo-vpc-${count.index}"
  }
}

resource "aws_internet_gateway" "monitoring_demo_gateway" {
  count = 3

  vpc_id = aws_vpc.monitoring_demo_vpc[count.index].id
}

resource "aws_subnet" "monitoring_demo_subnet" {
  count = 3

  vpc_id = aws_vpc.monitoring_demo_vpc[count.index].id

  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "monitoring-demo-${count.index} Public Subnet"
  }
}

resource "aws_route_table" "monitoring_demo_route_table" {
  count  = 3
  vpc_id = aws_vpc.monitoring_demo_vpc[count.index].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.monitoring_demo_gateway[count.index].id
  }

  tags = {
    Name = "monitoring-demo-${count.index} Public Subnet"
  }
}

resource "aws_route_table_association" "monitoring_demo_route_table_association" {
  count          = 3
  subnet_id      = aws_subnet.monitoring_demo_subnet[count.index].id
  route_table_id = aws_route_table.monitoring_demo_route_table[count.index].id
}

resource "aws_security_group" "monitoring_demo" {
  count  = 3
  name   = "monitoring-demo-${count.index}"
  vpc_id = aws_vpc.monitoring_demo_vpc[count.index].id

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
  ingress {
    from_port   = 30001
    to_port     = 30001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9345
    to_port     = 9345
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = [aws_vpc.monitoring_demo_vpc[count.index].cidr_block]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
