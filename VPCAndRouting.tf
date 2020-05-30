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

resource "aws_subnet" "unir_subnet_aplications" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "${var.SUBNET_CIDR_APLICATIONS}"
  availability_zone = "${var.ZONE_SUB}"
  depends_on = ["aws_internet_gateway.unir_gat_shop_dev"]
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
  depends_on = ["aws_internet_gateway.unir_gat_shop_dev"]
  map_public_ip_on_launch = true
  tags = {
    Name = "UNIR-SUBNET-CLUSTER-${var.SUFIX}-cluster-1"
    Environment = "${var.SUFIX}"
  }
}

resource "aws_subnet" "unir_subnet_cluster_2" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "${var.SUBNET_CIDR_CLUSTER_2}"
  availability_zone = "${var.ZONE_SUB_CLUSTER_2}"
  depends_on = ["aws_internet_gateway.unir_gat_shop_dev"]
  map_public_ip_on_launch = true
  tags = {
    Name = "UNIR-SUBNET-CLUSTER-${var.SUFIX}-cluster-2"
    Environment = "${var.SUFIX}"
  }
}

resource "aws_subnet" "unir_subnet_cluster_3" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "${var.SUBNET_CIDR_CLUSTER_3}"
  availability_zone = "${var.ZONE_SUB_CLUSTER_1}"
  depends_on = ["aws_internet_gateway.unir_gat_shop_dev"]
  map_public_ip_on_launch = true
  tags = {
    Name = "UNIR-SUBNET-CLUSTER-${var.SUFIX}-cluster-3"
    Environment = "${var.SUFIX}"
  }
}

resource "aws_subnet" "unir_subnet_cluster_4" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "${var.SUBNET_CIDR_CLUSTER_4}"
  availability_zone = "${var.ZONE_SUB_CLUSTER_1}"
  depends_on = ["aws_internet_gateway.unir_gat_shop_dev"]
  map_public_ip_on_launch = true
  tags = {
    Name = "UNIR-SUBNET-CLUSTER-${var.SUFIX}-cluster-4"
    Environment = "${var.SUFIX}"
  }
}

resource "aws_subnet" "unir_subnet_cluster_5" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "${var.SUBNET_CIDR_CLUSTER_5}"
  availability_zone = "${var.ZONE_SUB_CLUSTER_1}"
  depends_on = ["aws_internet_gateway.unir_gat_shop_dev"]
  map_public_ip_on_launch = true
  tags = {
    Name = "UNIR-SUBNET-CLUSTER-${var.SUFIX}-cluster-5"
    Environment = "${var.SUFIX}"
  }
}

resource "aws_subnet" "unir_subnet_cluster_6" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "${var.SUBNET_CIDR_CLUSTER_6}"
  availability_zone = "${var.ZONE_SUB_CLUSTER_1}"
  depends_on = ["aws_internet_gateway.unir_gat_shop_dev"]
  map_public_ip_on_launch = true
  tags = {
    Name = "UNIR-SUBNET-CLUSTER-${var.SUFIX}-cluster-6"
    Environment = "${var.SUFIX}"
  }
}

resource "aws_subnet" "unir_subnet_cluster_7" {
  vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  cidr_block = "${var.SUBNET_CIDR_CLUSTER_7}"
  availability_zone = "${var.ZONE_SUB_CLUSTER_1}"
  depends_on = ["aws_internet_gateway.unir_gat_shop_dev"]
  map_public_ip_on_launch = true
  tags = {
    Name = "UNIR-SUBNET-CLUSTER-${var.SUFIX}-cluster-7"
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


