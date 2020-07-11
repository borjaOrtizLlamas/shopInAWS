resource "aws_lb" "balancer" {
  name  = "APIRestBalancer-${var.SUFIX}"
  security_groups    = ["${aws_security_group.api_rest_group.id}"]
  subnets = ["${aws_subnet.unir_subnet_cluster_1.id}",
             "${aws_subnet.unir_subnet_cluster_2.id}"]
  tags = {
    Environment = "${var.SUFIX}"
    Name = "api-rest_balancer-${var.SUFIX}"
  }
}

resource "aws_lb_target_group" "targetForService" {
  name     = "targetForService-${var.SUFIX}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.unir_shop_vpc_dev.id}"
  target_type = "ip"
  depends_on = ["aws_lb.balancer"]

  tags = {
    Name = "targetForService-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.balancer.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.targetForService.arn}"
  }
}



resource "aws_lb_target_group" "kibana" {
  name     = "kibanaGroup-${var.SUFIX}"
  port     = 5601
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.unir_shop_vpc_dev.id}"

  tags = {
    Name = "targetkibanaGroup-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }
}


resource "aws_lb_listener" "kibana_front_end" {
  load_balancer_arn = "${aws_lb.balancer.arn}"
  port              = "5601"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.kibana.arn}"
  }
}
