
module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "3.7.0"
  name                 = var.name
  cidr                 = var.cidr
  azs                  = slice(var.availability_zones_names, 0, 2)
  private_subnets      = ["${cidrsubnet(var.cidr, 8, 1)}", "${cidrsubnet(var.cidr, 8, 2)}", "${cidrsubnet(var.cidr, 8, 3)}"]
  public_subnets       = ["${cidrsubnet(var.cidr, 8, 4)}", "${cidrsubnet(var.cidr, 8, 5)}", "${cidrsubnet(var.cidr, 8, 6)}"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}-${var.environment}" = "shared"
    "kubernetes.io/role/elb"                                       = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}-${var.environment}" = "shared"
    "kubernetes.io/role/internal-elb"                              = "1"
  }

  tags = {
    "Name" = "${var.name}-${var.environment}"
  }
}