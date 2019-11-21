resource "aws_vpc" "infra-main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = false
  enable_dns_support   = true
  instance_tenancy     = "default"
tags = {
    Site = "infra-web-site"
    Name = "infra-vpc"
  }
}
data "aws_availability_zones" "available" {}
resource "aws_subnet" "infra-public1" {
  vpc_id                  = "aws_vpc.infra-main.id"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = true
tags = {
    Name = "infra-public2"
    Site = "infra-web-site"
  }
}
resource "aws_subnet" "infra-public2" {
  vpc_id                  = "aws_vpc.infra-main.id"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = true
tags = {
    Name = "infra-public1"
    Site = "infra-web-site"
  }
}
resource "aws_subnet" "infra-public3" {
  vpc_id                  = "aws_vpc.infra-main.id"
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"
  map_public_ip_on_launch = true
tags = {
    Name = "infra-public3"
    Site = "infra-web-site"
  }
}
resource "aws_subnet" "infra-private1" {
  vpc_id                  = "aws_vpc.infra-main.id"
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "infra-private1"
    Site = "infra-web-site"
  }
}
resource "aws_subnet" "infra-private2" {
  vpc_id                  = "aws_vpc.infra-main.id"
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = true
tags = {
    Name = "infra-private2"
    Site = "infra-web-site"
  }
}
resource "aws_subnet" "infra-private3" {
  vpc_id                  = "aws_vpc.infra-main.id"
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"
  map_public_ip_on_launch = true
tags = {
    Name = "infra-private3"
    Site = "infra-web-site"
  }
}
resource "aws_internet_gateway" "infra-igw" {
  vpc_id = "aws_vpc.infra-main.id"
  tags = {
    Name = "infra-igw"
    Site = "infra-web-site"
  }
}
resource "aws_route_table" "infra-rt" {
  vpc_id = "aws_vpc.infra-main.id"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "aws_internet_gateway.infra-igw.id"
  }
  tags = {
    Site = "infra-web-site"
    Name = "infra-rt"
  }
}

resource "aws_route_table_association" "infra-public1" {
  subnet_id      = "${aws_subnet.infra-public1.id}"
  route_table_id = "${aws_route_table.infra-rt.id}"
}
resource "aws_route_table_association" "infra-public2" {
  subnet_id      = "${aws_subnet.infra-public2.id}"
  route_table_id = "${aws_route_table.infra-rt.id}"
}
resource "aws_route_table_association" "infra-public3" {
  subnet_id      = "${aws_subnet.infra-public3.id}"
  route_table_id = "${aws_route_table.infra-rt.id}"
}
