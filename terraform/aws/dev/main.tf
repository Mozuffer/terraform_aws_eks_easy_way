resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/taly_deployer_key/deployer.pub")
}
module "vpc" {
  source                   = "../modules/vpc"
  name                     = "aws-eks"
  environment              = "development"
  availability_zones_names = data.aws_availability_zones.available.names
  cidr                     = "172.16.0.0/16"
  cluster_name             = "aws-eks"
}

module "iam" {
  source                     = "../modules/iam"
  environment                = "development"
  eks_cluster_role_name      = "eks-cluster-role"
  eks_cluster_node_role_name = "eks-cluster-nodegroup-role"
}

module "eks" {
  # eks_cluster config 
  source             = "../modules/eks"
  environment        = "development"
  cluster_name       = "aws-eks"
  cluster_role_arn   = module.iam.role_eks_cluster_arn
  cluster_subnet_ids = concat(module.vpc.public_subnets[*], module.vpc.private_subnets[*])
  # node_group config 
  node_group_name         = "aws-eks-nodegroup"
  node_role_arn           = module.iam.role_eks_nodes_arn
  node_group_subnet_ids   = module.vpc.private_subnets[*]
  node_group_keypair_name = aws_key_pair.deployer.key_name
  instance_types          = ["t3.medium"]
  scaling_config_desired_size = 2
  scaling_config_max_size    = 10
  scaling_config_min_size    = 2

  # Ensures that IAM Roles are created for the EKS cluster and Node Group
  depends_on = [
    module.iam.role_policy_attachment_AmazonEKSClusterPolicy,
    module.iam.role_policy_attachment_AmazonEKSServicePolicy,
    module.iam.role_policy_attachment_AmazonEKSWorkerNodePolicy,
    module.iam.role_policy_attachment_AmazonEKS_CNI_Policy,
    module.iam.role_policy_attachment_AmazonEC2ContaonerRegistryReadOnly,
    module.iam.role_policy_attachment_cluster_autoscaler,
  ]
}
