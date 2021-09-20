output "role_policy_attachment_AmazonEKSClusterPolicy" {
  value = aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
}

output "role_policy_attachment_AmazonEKSServicePolicy" {
  value = aws_iam_role_policy_attachment.AmazonEKSServicePolicy
}

output "role_policy_attachment_AmazonEKSWorkerNodePolicy" {
  value = aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy
}

output "role_policy_attachment_AmazonEKS_CNI_Policy" {
  value = aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
}

output "role_policy_attachment_AmazonEC2ContaonerRegistryReadOnly" {
  value = aws_iam_role_policy_attachment.AmazonEC2ContaonerRegistryReadOnly
}

output "role_policy_attachment_cluster_autoscaler" {
  value = aws_iam_role_policy_attachment.cluster_autoscaler
}
output "role_eks_cluster_arn" {
  value = aws_iam_role.eks-cluater.arn
}

output "role_eks_nodes_arn" {
  value = aws_iam_role.eks-nodes.arn
}
