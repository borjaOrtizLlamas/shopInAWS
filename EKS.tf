resource "aws_eks_cluster" "CLUSTER" {
  name     = "UNIR-API-REST-CLUSTER"
  role_arn = "${aws_iam_role.cluster-role.arn}"

  vpc_config {
    subnet_ids = ["${aws_subnet.unir_subnet_cluster_2.id}", "${aws_subnet.unir_subnet_cluster_1.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.AmazonEKSClusterPolicy"
  ]
}

output "endpoint" {
  value = "${aws_eks_cluster.CLUSTER.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.CLUSTER.certificate_authority.0.data}"
}