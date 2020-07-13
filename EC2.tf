resource "aws_instance" "mongoDB" {
  ami = "ami-01b128ace52c782a0" 
  instance_type = "t2.micro"
  availability_zone = "${var.ZONE_SUB}"
  key_name = "${aws_key_pair.mongoSSH.key_name}"

  network_interface {
    network_interface_id = "${aws_network_interface.mongo_interface.id}"
    device_index = 0
  }
  tags = {
    Name = "MongoDB-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
}


resource "aws_instance" "kibana" {
  ami = "ami-07af44fbe70885f2f"
  instance_type = "t2.medium"
  availability_zone = "${var.ZONE_SUB}"
  key_name = "${aws_key_pair.kibanaSSH.key_name}"
  network_interface {
    network_interface_id = "${aws_network_interface.kibana_interface.id}"
    device_index = 0
  }
  tags = {
    Name = "kibana-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
}

resource "aws_network_interface" "mongo_interface" {
    subnet_id   = "${aws_subnet.unir_subnet_aplications.id}"
    security_groups = ["${aws_security_group.mongo_access.id}"]
    tags = {
        Name = "unir_mongo_interface-${var.SUFIX}"
        Environment = "${var.SUFIX}"
    }
}

resource "aws_network_interface" "kibana_interface" {
    subnet_id   = "${aws_subnet.unir_subnet_aplications.id}"
    security_groups = ["${aws_security_group.kibana_access.id}"]
    tags = {
        Name = "unir_kibana_interface-${var.SUFIX}"
        Environment = "${var.SUFIX}"
    }
}


#resource "aws_eip" "mongoEIP" {
#  depends_on = ["aws_internet_gateway.unir_gat_shop"]
#  vpc = true
#  instance = "${aws_instance.mongoDB.id}"
#}
#resource "aws_eip" "kibanaEIP" {
#  depends_on = ["aws_internet_gateway.unir_gat_shop"]
#  vpc = true
#  instance = "${aws_instance.kibana.id}"
#}