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


resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = "{aws_iam_role.CLUSTER_ROLE.id}"

  policy = <<-EOF
   {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "ec2:CreateNetworkInterface",
                  "ec2:DeleteNetworkInterface",
                  "ec2:DetachNetworkInterface",
                  "ec2:ModifyNetworkInterfaceAttribute",
                  "ec2:DescribeInstances",
                  "ec2:DescribeNetworkInterfaces",
                  "ec2:DescribeSecurityGroups",
                  "ec2:DescribeSubnets",
                  "ec2:DescribeVpcs",
                  "ec2:CreateNetworkInterfacePermission",
                  "iam:ListAttachedRolePolicies",
                  "ec2:CreateSecurityGroup"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "ec2:DeleteSecurityGroup",
                  "ec2:RevokeSecurityGroupIngress",
                  "ec2:AuthorizeSecurityGroupIngress"
              ],
              "Resource": "arn:aws:ec2:*:*:security-group/*",
              "Condition": {
                  "ForAnyValue:StringLike": {
                      "ec2:ResourceTag/Name": "eks-cluster-sg*"
                  }
              }
          },
          {
              "Effect": "Allow",
              "Action": [
                  "ec2:CreateTags",
                  "ec2:DeleteTags"
              ],
              "Resource": [
                  "arn:aws:ec2:*:*:vpc/*",
                  "arn:aws:ec2:*:*:subnet/*"
              ],
              "Condition": {
                  "ForAnyValue:StringLike": {
                      "aws:TagKeys": [
                          "kubernetes.io/cluster/*"
                      ]
                  }
              }
          },
          {
              "Effect": "Allow",
              "Action": [
                  "ec2:CreateTags",
                  "ec2:DeleteTags"
              ],
              "Resource": [
                  "arn:aws:ec2:*:*:security-group/*"
              ],
              "Condition": {
                  "ForAnyValue:StringLike": {
                      "aws:TagKeys": [
                          "kubernetes.io/cluster/*"
                      ],
                      "aws:RequestTag/Name": "eks-cluster-sg*"
                  }
              }
          },
          {
              "Effect": "Allow",
              "Action": "route53:AssociateVPCWithHostedZone",
              "Resource": "arn:aws:route53:::hostedzone/*"
          },
          {
              "Effect": "Allow",
              "Action": "logs:CreateLogGroup",
              "Resource": "arn:aws:logs:*:*:log-group:/aws/eks/*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "logs:CreateLogStream",
                  "logs:DescribeLogStreams"
              ],
              "Resource": "arn:aws:logs:*:*:log-group:/aws/eks/*:*"
          },
          {
              "Effect": "Allow",
              "Action": "logs:PutLogEvents",
              "Resource": "arn:aws:logs:*:*:log-group:/aws/eks/*:*:*"
          }
      ]
    }
  EOF
}

resource "aws_iam_role" "CLUSTER_ROLE" {
  name = "UNIR_CLUSTER_ROLE"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}