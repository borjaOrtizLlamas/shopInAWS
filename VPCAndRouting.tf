resource "aws_vpc" "unir_shop_vpc_dev" {
  cidr_block = "172.15.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "UNIR-VPC-SHOP"
  }
}
resource "aws_route_table" "route" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.unir_gat_shop_dev.id}"
  }
  tags = {
    Name = "UNIR-RoutePublic"
  }
}

resource "aws_subnet" "unir_subnet_shop_dev" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "172.15.0.0/24"
  availability_zone = "${var.ZONE_SUB}"
  depends_on = ["aws_internet_gateway.unir_gat_shop_dev"]
  map_public_ip_on_launch = true
  tags = {
    Name = "UNIR-SUBNET-JENKINS"
  }
}

resource "aws_internet_gateway" "unir_gat_shop_dev" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  tags = {
    Name = "UNIR-publicGateway"
  }
}


