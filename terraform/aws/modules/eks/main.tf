resource "aws_eks_cluster" "aws_eks" {
  name     = "${var.cluster_name}-${var.environment}"
  version  = "1.21"
  role_arn = var.cluster_role_arn
  vpc_config {
    subnet_ids = var.cluster_subnet_ids
  }
  tags = {
    "Name" = "${var.cluster_name}-${var.environment}"
  }
}
resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = "${var.node_group_name}-${var.environment}"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.node_group_subnet_ids
  instance_types  = var.instance_types
  remote_access {
    ec2_ssh_key = var.node_group_keypair_name
  }
  scaling_config {
    desired_size = var.scaling_config_desired_size
    max_size     = var.scaling_config_max_size
    min_size     = var.scaling_config_min_size
  }
}
