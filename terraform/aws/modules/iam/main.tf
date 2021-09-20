resource "aws_iam_role" "eks-cluater" {
  name = "${var.eks_cluster_role_name}-${var.environment}"
  # Ensure that the AmazonEKSClusterPolicy is attached to the role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
      "Service": "eks.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
    }
 ]   
}
POLICY 
}

# This policy provides k8s the permission it require to manage resources on your behalf.
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluater.name
}

#This policy allows Amazon Elastic Container Service for k8s to create and manage the necessary resources to operate EKS cluster. 
resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks-cluater.name
}

# Ensure that the AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy and  AmazonEC2ContainerRegistryReadOnly are attached to the role
resource "aws_iam_role" "eks-nodes" {
  name               = "${var.eks_cluster_node_role_name}-${var.environment}"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
      "Service": "ec2.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
    }
  ]    
} 
POLICY 
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-nodes.name
}

# This policy provides the amazon VPC CNI plugin the permission it requires to modify the IP address configuration on your EKS worker nodes.
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContaonerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-nodes.name

}