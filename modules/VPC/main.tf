resource "aws_vpc" "vnet" {
    cidr_block = var.vpc_cidr_block

    tags = {
        name = var.vpc_name
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vnet.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.subnet_az
    map_public_ip_on_launch =  var.public_ip
    tags = {
        name = var.subnet_name 
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vnet.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vnet.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
}

resource "aws_route_table_association" "rt-sub" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.public.id
}

resource "aws_security_group" "firewall" {
  name = "modules-sg"
  description = "connect to modules"
  vpc_id = aws_vpc.vnet.id

  ingress {
    from_port = var.ports[0]
    to_port = var.ports[0]
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = var.ports[1]
    to_port = var.ports[1]
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}