resource "aws_instance" "mongoDB_des" {
  ami = "ami-094b9268f67ec66fc" #This ami is generated with packer, the code is in this repository: https://github.com/borjaOrtizLlamas/jenkinsAMI.git
  instance_type = "t2.micro"
  availability_zone = "${var.ZONE_SUB}"
  key_name = "${aws_key_pair.mongoSSH.key_name}"
  network_interface {
    network_interface_id = "${aws_network_interface.mongo_interface.id}"
    device_index = 0
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
}

resource "aws_network_interface" "mongo_interface" {
    subnet_id   = "${aws_subnet.unir_subnet_shop_dev.id}"
    security_groups = ["${aws_security_group.mongo_access.id}"]
    tags = {
        Name = "unir_mongo_interface"
    }
}

resource "aws_key_pair" "mongoSSH" {
  key_name   = "mongoSSH"
  public_key = "${var.MONGO_SSH_KEY}"
}