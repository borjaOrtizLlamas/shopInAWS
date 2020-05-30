resource "aws_eks_cluster" "CLUSTER" {
  name     = "UNIR-API-REST-CLUSTER-${var.SUFIX}"
  role_arn = "${aws_iam_role.eks_cluster_role.arn}"

  vpc_config {
    subnet_ids = ["${aws_subnet.unir_subnet_cluster_2.id}", "${aws_subnet.unir_subnet_cluster_1.id}"]
  }
}



output "endpoint" {
  value = "${aws_eks_cluster.CLUSTER.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.CLUSTER.certificate_authority.0.data}"
}
