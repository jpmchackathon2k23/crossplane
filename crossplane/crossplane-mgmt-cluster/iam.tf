# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 1.0.4"
#     }
#   }

# }

provider "aws" {
    region = "us-east-1"
    profile = "adfs"

}


resource "aws_iam_role" "hc_2023_mgmt_cluster_role" {
  name = "hc_cluster_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "HC2023MgmtClusterRole"
  }
}


resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.hc_2023_mgmt_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks-cluster-service-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role = aws_iam_role.hc_2023_mgmt_cluster_role.name
}


resource "aws_iam_role_policy_attachment" "eks-cluster-admin-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role = aws_iam_role.hc_2023_mgmt_cluster_role.name
}

resource "aws_iam_role" "hc_2023_mgmt_worker_node_role" {
  name = "hc_worker_node_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "HC2023MgmtWorkerNodeRole"
  }
}

resource "aws_iam_role_policy_attachment" "eks-worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.hc_2023_mgmt_worker_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks-worker_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.hc_2023_mgmt_worker_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks-worker_container_registry" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.hc_2023_mgmt_worker_node_role.name
}