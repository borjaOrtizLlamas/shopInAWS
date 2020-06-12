resource "aws_ecs_cluster" "api_rest_cluster" {
  name = "api_rest_cluster"
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_ecs_task_definition" "APIRestSmallCompany" {
    family = "APIRestSmallCompany"
    container_definitions = file("containers.json") #funciona
    volume {
        name      = "logs"
    }
    requires_compatibilities = ["FARGATE"]
    memory = 1024
    cpu = 512
    network_mode= "awsvpc"
    execution_role_arn = "${data.aws_iam_role.ecs_task_execution_role.arn}"
}

resource "aws_ecs_service" "service_for_api" {
  name            = "serviceApiRest"
  cluster         = "${aws_ecs_cluster.api_rest_cluster.id}"
  task_definition = "${aws_ecs_task_definition.APIRestSmallCompany.arn}"
  desired_count   = 2
  launch_type = "FARGATE"
  network_configuration {
    subnets = ["${aws_subnet.unir_subnet_cluster_1.id}",
    "${aws_subnet.unir_subnet_cluster_2.id}"]
    security_groups = ["${aws_security_group.api_rest_group.id}"]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = "${aws_lb_target_group.targetForService.arn}"
    container_name   = "smallComerceApiRest"
    container_port   = 8080
  }
}