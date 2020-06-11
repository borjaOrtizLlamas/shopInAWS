##########
## api_rest
##########

resource "aws_security_group" "api_rest_group" {
  name        = "api rest group"
  description = "Api rest security"
  vpc_id      = "${aws_vpc.unir_shop_vpc_dev.id}"
  tags = {
    Name = "api rest group"
  }
}

resource "aws_security_group_rule" "api_rest_outbound" {
  type              = "egress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.api_rest_group.id}"
}

resource "aws_security_group_rule" "api_rest_ingress" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.api_rest_group.id}"
}


resource "aws_security_group_rule" "get_container_egress" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.api_rest_group.id}"
}

resource "aws_security_group_rule" "get_container_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.api_rest_group.id}"
}

resource "aws_security_group_rule" "get_container_https_egress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.api_rest_group.id}"
}

resource "aws_security_group_rule" "get_container_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.api_rest_group.id}"
}


##########
## mongo
##########
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


##########
## kibana 
##########

resource "aws_security_group" "kibana_access" {
  name        = "allow kibana"
  description = "Allow kibana inbound traffic and all outbound trafic"
  vpc_id      = "${aws_vpc.unir_shop_vpc_dev.id}"
  tags = {
    Name = "allow-kibana-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }
}

resource "aws_security_group_rule" "ssh_outbound" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kibana_access.id}"
}
resource "aws_security_group_rule" "elastic_outbound" {
  type              = "egress"
  from_port         = 9200
  to_port           = 9200
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kibana_access.id}"
}
resource "aws_security_group_rule" "kibana_outbound" {
  type              = "egress"
  from_port         = 5601
  to_port           = 5601
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kibana_access.id}"
}

resource "aws_security_group_rule" "ssh_rule_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kibana_access.id}"
}

resource "aws_security_group_rule" "elastic_outbound" {
  type              = "ingress"
  from_port         = 9200
  to_port           = 9200
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kibana_access.id}"
}

resource "aws_security_group_rule" "kibana_outbound" {
  type              = "ingress"
  from_port         = 5601
  to_port           = 5601
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kibana_access.id}"
}

###################



# Setup for IAM role needed to setup an EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-${var.SUFIX}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role" "eks_nodes_role" {
  name = "eks-node-${var.SUFIX}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.eks_cluster_role.name}"
}

resource "aws_key_pair" "mongoSSH" {
  key_name   = "mongoSHH-${var.SUFIX}"
  public_key = "${var.MONGO_SSH_KEY}"
}

resource "aws_key_pair" "kibanaSSH" {
  key_name   = "kibanaSSH-${var.SUFIX}"
  public_key = "${var.KIBANA_SSH_KEY}"
}

resource "aws_key_pair" "clusters" {
  key_name   = "clusters-${var.SUFIX}"
  public_key = "${var.CLUSTER_SSH_KEY}"
}