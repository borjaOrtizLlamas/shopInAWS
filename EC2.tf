resource "aws_instance" "mongoDB_des" {
  ami = "ami-0bbb90fb58907eeb3" #This ami is generated with packer, the code is in this repository: https://github.com/borjaOrtizLlamas/jenkinsAMI.git
  instance_type = "t2.micro"
  availability_zone = "${var.ZONE_SUB}"
  key_name = "mongoSHH"
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

resource "aws_network_interface" "mongo_interface" {
    subnet_id   = "${aws_subnet.unir_subnet_aplications.id}"
    security_groups = ["${aws_security_group.mongo_access.id}"]
    tags = {
        Name = "unir_mongo_interface-${var.SUFIX}"
        Environment = "${var.SUFIX}"
    }
}

