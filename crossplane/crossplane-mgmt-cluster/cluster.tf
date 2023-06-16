resource "aws_eks_cluster" "crossplane-mgmt-cluster" {
  name     = "crossplane-mgmt-cluster"
  role_arn = aws_iam_role.hc_2023_mgmt_cluster_role.arn
  version = "1.25"  
  
  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = [aws_security_group.cluster_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-policy,
    aws_iam_role_policy_attachment.eks-cluster-service-policy,
  ]
}
