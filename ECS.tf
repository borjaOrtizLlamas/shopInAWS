#resource "aws_eks_cluster" "CLUSTER" {
#  name     = "UNIR-API-REST-CLUSTER-${var.SUFIX}"
#  role_arn = "${aws_iam_role.eks_cluster_role.arn}"
#  vpc_config {
#    subnet_ids = [
#      "${aws_subnet.unir_subnet_cluster_1.id}","${aws_subnet.unir_subnet_cluster_2.id}"
#    ]
#  }
#}


#resource "aws_eks_node_group" "nodes" {
#  cluster_name    = "${aws_eks_cluster.CLUSTER.name}"
#  node_group_name = "node_sping_boot"
#  node_role_arn   = "${aws_iam_role.eks_nodes_role.arn}"
#  subnet_ids      = [
#      "${aws_subnet.unir_subnet_cluster_1.id}","${aws_subnet.unir_subnet_cluster_2.id}"
#  ]
#  scaling_config {
#    desired_size = 1
#    max_size     = 5
#    min_size     = 1
# }
# instance_types is mediumt3 by default
# Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
# Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#  depends_on = [
#    "aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy",
#    "aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy",
#    "aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly",
#  ]
#}

#output "eks_cluster_endpoint" {
#  value = "${aws_eks_cluster.CLUSTER.endpoint}"
#}

#output "eks_cluster_certificat_authority" {
#    value = "${aws_eks_cluster.CLUSTER.certificate_authority}"
#}

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
    memory = 2048
    cpu = 1024
    network_mode= "awsvpc"
    execution_role_arn = "${data.aws_iam_role.ecs_task_execution_role.arn}"
}


#resource "aws_ecs_service" "service_for_api" {
#  name            = "serviceApiRest"
#  cluster         = "${aws_ecs_cluster.api_rest_cluster.id}"
#  task_definition = "${aws_ecs_task_definition.APIRestSmallCompany.arn}"
#  desired_count   = 2
##  launch_type = "FARGATE"
#  network_configuration {
#    subnets = ["${aws_subnet.unir_subnet_cluster_1.id}",
#    "${aws_subnet.unir_subnet_cluster_2.id}"]
#    security_groups = ["${aws_security_group.api_rest_group.id}"]
#  }
#}
