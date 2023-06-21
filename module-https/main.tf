## Provides a VPC resource 
resource "aws_vpc" "elearning-VPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance-tenancy
  enable_dns_hostnames = var.vpc-dns-hostnames
  enable_dns_support   = var.vpc_dns_support
  tags = {
    Name = "${var.project_name}-VPC"
  }
}

## Create 2 subnets (1 in each) of the first two available availability zones
#  public subnets 
resource "aws_subnet" "public-subnets" {
  count               = length(var.public-subnet_ids)
  availability_zone   = data.aws_availability_zones.aws-AZs.names[count.index]
  
  vpc_id              = aws_vpc.elearning-VPC.id
  cidr_block          = element(var.public-subnet_ids, count.index)
  
  tags = {
    Name              = "elearn-public-subnet-${count.index +1}"
  }
}

# private subnets
resource "aws_subnet" "private-subnets" {
  count               = length(var.private-subnet_ids)
  availability_zone   = data.aws_availability_zones.aws-AZs.names[count.index]

  vpc_id              = aws_vpc.elearning-VPC.id
  cidr_block          = element(var.private-subnet_ids, count.index)
  
  tags = {
    Name              = "elearn-priv-subnet-${count.index +1}"
  }
}


# public route table
resource "aws_route_table" "elearn-public-rtb" {
  vpc_id      = aws_vpc.elearning-VPC.id

  tags        = {
    Name      = var.public-route-table     
  }
}

# private route table
resource "aws_route_table" "elearn-private-rtb" {
  vpc_id      = aws_vpc.elearning-VPC.id

  tags        = {
    Name      = var.private-route-table
  }
}

#Public route table association with subnets (public)
resource "aws_route_table_association" "public-route-association" {
  count          = length(var.public-subnet_ids)
  subnet_id      = "${aws_subnet.public-subnets[count.index].id}"
  route_table_id = aws_route_table.elearn-public-rtb.id
}


#Private route table association with subnets (private)
resource "aws_route_table_association" "private-route-association" {
  count          = length(var.private-subnet_ids)
  subnet_id      = "${aws_subnet.private-subnets[count.index].id}"
  route_table_id = aws_route_table.elearn-private-rtb.id
}


#Internet gateway to communicate with public route table
resource "aws_internet_gateway" "elearning-igw" {
  vpc_id      = aws_vpc.elearning-VPC.id
  tags        = {
    Name      = var.igw-Name
  }
}

# Route internet gateway to associate with public route table
resource "aws_route" "elearning-igw-association" {
  route_table_id            = aws_route_table.elearn-public-rtb.id
  destination_cidr_block    = var.destin-cidr_block
  gateway_id                = aws_internet_gateway.elearning-igw.id
}

#provision elastic IP for public NAT Gateway 
resource "aws_eip" "elearn-EIP" {
    vpc                       = var.vpc_elastic-ip
    depends_on                = [aws_internet_gateway.elearning-igw]
    tags = {
        Name                  = var.eip-Name
  }
}

# public NAT gateway put in a public subnet
resource "aws_nat_gateway" "elearning-Nat-gateway" {
  connectivity_type       = var.NAT-connectivity_type
  allocation_id           = aws_eip.elearn-EIP.id
  subnet_id               = aws_subnet.public-subnets[0].id
  tags = {
    Name                  = var.NAT-Name
  }
    # To ensure proper ordering, it is recommended to add an explicit dependency
    # on the Internet Gateway for the VPC.
  depends_on              = [aws_internet_gateway.elearning-igw]
}

# NAT gateway to associate with private route table
resource "aws_route" "elearning-Nat-association" {
  route_table_id            = aws_route_table.elearn-private-rtb.id
  destination_cidr_block    = var.NAT-destin-cidr_block
  gateway_id                = aws_nat_gateway.elearning-Nat-gateway.id
}


