# Створення Elastic IP
resource "aws_eip" "nat_eip" {
}

# Створення NAT Gateway і призначення Elastic IP
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.private-subnet.id
}

# Оновлення маршрутизації в приватній підмережі
resource "aws_route_table" "route_table_nat" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.route_table_nat.id
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.vpc.id
}
