## Create recources
resource "aws_vpc" "jenkins-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name : "${var.env_prefix}-vpc"
  }
}

# Data source to get the list of Availability Zones
data "aws_availability_zones" "available" {}

# Create subnets in each availability zone dynamically
resource "aws_subnet" "jenkins-subnet" {
  for_each          = toset(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.jenkins-vpc.id
  cidr_block        = cidrsubnet(var.subnet_cidr_block, 8, index(data.aws_availability_zones.available.names, each.key))
  availability_zone = each.value
  tags = {
    Name = "${var.env_prefix}-subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "jenkins-igw" {
  vpc_id = aws_vpc.jenkins-vpc.id
  tags = {
    Name : "${var.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.jenkins-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins-igw.id
  }
  tags = {
    Name : "${var.env_prefix}-main-rtb"
  }
}
