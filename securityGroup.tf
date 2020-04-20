resource "aws_security_group" "mongo_access" {
  name        = "allow mongo"
  description = "Allow mongo inbound traffic and all outbound trafic"
  vpc_id      = "${aws_vpc.unir_shop_vpc_dev.id}"
  tags = {
    Name = "allow mongo"
  }
}

resource "aws_security_group_rule" "mongo_outbound" {
  type              = "egress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.mongo_access.id}"
}

resource "aws_security_group_rule" "ssh_outbound" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.mongo_access.id}"
}


#seguridad, acepta SSH
resource "aws_security_group_rule" "ssh_rule_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.mongo_access.id}"
}

resource "aws_security_group_rule" "mongo_ingress" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.mongo_access.id}"
}