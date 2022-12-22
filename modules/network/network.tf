data "aws_availability_zones" "vpc_azs" {
  state = "available"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = "${var.enviroment}-igw-${aws_vpc.main.tags.Name}"
    },
  )
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.manually_created.id
}

resource "aws_route_table" "manually_created" {
  vpc_id      = aws_vpc.main.id

  route {
    cidr_block = var.rt_cidr
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = merge(
    var.tags,
    {
      Name = "manually_created"
    },
  )
}
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.main.id
  count = var.public_subnets_per_vpc
  availability_zone = data.aws_availability_zones.vpc_azs.names[count.index]
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 2, count.index)
  map_public_ip_on_launch = "true"

  tags = merge(
    var.tags,
    {
      Name = "${var.enviroment}-subnet-${count.index+1}"
    },
  )  
}

resource "aws_route_table_association" "public" {
  count = var.public_subnets_per_vpc
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = aws_route_table.manually_created.id
}

resource "aws_vpc" "main" {
  cidr_block = cidrsubnet(var.vpc_cidr, 4, 2)
  instance_tenancy = "default"
  tags = merge(
    var.tags,
    {
      Name = "vpc-${var.enviroment}"
    },
  )  
}



