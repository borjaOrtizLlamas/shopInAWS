resource "aws_lb" "balancer" {
  name  = "api-rest_balancer-${var.SUFIX}"
  security_groups    = ["${aws_security_group.api_rest_group.id}"]
  subnets = ["${aws_subnet.unir_subnet_cluster_1.id}",
             "${aws_subnet.unir_subnet_cluster_2.id}"]
  tags = {
    Environment = "${var.SUFIX}"
    Name = "api-rest_balancer-${var.SUFIX}"
  }
}
