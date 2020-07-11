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
    gateway_id = "${aws_internet_gateway.unir_gat_shop.id}"
  }
  tags = {
    Name = "UNIR-RoutePublic-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }
}
resource "aws_subnet" "unir_subnet_aplications" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "${var.SUBNET_CIDR_APLICATIONS}"
  availability_zone = "${var.ZONE_SUB}"
  depends_on = ["aws_internet_gateway.unir_gat_shop"]
  map_public_ip_on_launch = true
  tags = {
    Name = "UNIR-SUBNET-APLICATIONS-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }
}

resource "aws_subnet" "unir_subnet_cluster_1" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "${var.SUBNET_CIDR_CLUSTER_1}"
  availability_zone = "${var.ZONE_SUB_CLUSTER_1}"
  map_public_ip_on_launch = true
  tags = {
    "kubernetes.io/cluster/UNIR-API-REST-CLUSTER-${var.SUFIX}" = "shared"
    Name = "UNIR-SUBNET-CLUSTER-1-${var.SUFIX}"
    Environment = "${var.SUFIX}"

  }
}

resource "aws_subnet" "unir_subnet_cluster_2" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "${var.SUBNET_CIDR_CLUSTER_2}"
  availability_zone = "${var.ZONE_SUB_CLUSTER_2}"
  map_public_ip_on_launch = true
  tags = {
    "kubernetes.io/cluster/UNIR-API-REST-CLUSTER-${var.SUFIX}" = "shared"
    Name = "UNIR-SUBNET-CLUSTER-2-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }

}

resource "aws_internet_gateway" "unir_gat_shop" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  tags = {
    Environment = "${var.SUFIX}"
    Name = "UNIR-publicGateway-SHOP-VPC-${var.SUFIX}"
  }
}

resource "aws_route_table_association" "association-cluster-1" {
  subnet_id      = "${aws_subnet.unir_subnet_cluster_1.id}"
  route_table_id = "${aws_route_table.route.id}"
}

resource "aws_route_table_association" "association-cluster-2" {
  subnet_id      = "${aws_subnet.unir_subnet_cluster_2.id}"
  route_table_id = "${aws_route_table.route.id}"
}

resource "aws_route_table_association" "unir_subnet_aplications" {
  subnet_id      = "${aws_subnet.unir_subnet_aplications.id}"
  route_table_id = "${aws_route_table.route.id}"
}

