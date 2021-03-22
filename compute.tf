data "aws_eks_cluster" "cluster" {
  name = module.cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks.cluster_name
  cluster_version = var.eks.compute.eks_version
  subnets         = flatten([module.vpc.public_subnets, module.vpc.private_subnets])
  vpc_id          = module.vpc.vpc_id

  cluster_endpoint_public_access  = var.eks.networking.public_access
  cluster_endpoint_private_access = var.eks.networking.private_access

  cluster_endpoint_private_access_cidrs = module.vpc.private_subnets
  cluster_endpoint_public_access_cidrs  = var.eks.networking.public_access_cidrs

  worker_groups = [
    {
      instance_type        = var.eks.compute.instance_size
      asg_desired_capacity = var.eks.compute.nodes
      asg_max_size         = var.eks.compute.nodes_min
      asg_max_size         = var.eks.compute.nodes_max
    }
  ]
}