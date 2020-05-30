resource "aws_eks_cluster" "CLUSTER" {
  name     = "UNIR-API-REST-CLUSTER-${var.SUFIX}"
  role_arn = "${aws_iam_role.eks_cluster_role.arn}"

  vpc_config {
    subnet_ids = ["${aws_subnet.unir_subnet_cluster_2.id}", "${aws_subnet.unir_subnet_cluster_1.id}"]
  }
}

resource "aws_eks_node_group" "eks_node" {
  cluster_name    = "${aws_eks_cluster.CLUSTER.name}"
  node_group_name = "shop_node_groups_${var.SUFIX}"
  node_role_arn   ="${aws_iam_role.eks_nodes_role.arn}"
  subnet_ids      = ["${aws_subnet.unir_subnet_cluster_2.id}", "${aws_subnet.unir_subnet_cluster_1.id}"]
  
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    "aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy",
    "aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy",
    "aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly"
  ]
}


output "endpoint" {
  value = "${aws_eks_cluster.CLUSTER.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.CLUSTER.certificate_authority.0.data}"
}
