resource "aws_vpc" "unir_shop_vpc_dev" {
  cidr_block = "${var.NET_CIDR_BLOCK}"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "UNIR-VPC-SHOP-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }
}
resource "aws_route_table" "route" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.unir_gat_shop_dev.id}"
  }
  tags = {
    Name = "UNIR-RoutePublic-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }
}

resource "aws_subnet" "unir_subnet_shop_dev" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "${var.SUBNET_CIDR_BLOCK}"
  availability_zone = "${var.ZONE_SUB}"
  depends_on = ["aws_internet_gateway.unir_gat_shop_dev"]
  map_public_ip_on_launch = true
  tags = {
    Name = "UNIR-SUBNET-SHOP-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }
}

resource "aws_internet_gateway" "unir_gat_shop_dev" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  tags = {
    Environment = "${var.SUFIX}"
    Name = "UNIR-publicGateway-${var.SUFIX}"
  }
}


