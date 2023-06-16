resource "aws_eks_node_group" "cluster_worker_node" {
  cluster_name    = aws_eks_cluster.crossplane-mgmt-cluster.name
  node_group_name = "crossplane-mgmt-node"
  node_role_arn   = aws_iam_role.hc_2023_mgmt_worker_node_role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-worker_node_policy,
    aws_iam_role_policy_attachment.eks-worker_cni_policy,
    aws_iam_role_policy_attachment.eks-worker_container_registry,
  ]
}