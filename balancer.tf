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
  name     = "targetForService"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.unir_shop_vpc_dev.id}"
    tags = {
    Name = "targetForService-${var.SUFIX}"
    Environment = "${var.SUFIX}"
  }

}


resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_lb_target_group.targetForService.arn}"
  target_id        = "${aws_ecs_service.service_for_api.id}"
  port             = 8080
}
