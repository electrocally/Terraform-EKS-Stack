data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.network.vpc_name
  cidr = var.network.base_cidr

  azs = data.aws_availability_zones.available.names

  public_subnets = [for index in range(var.network.public_subnets_count) :
    cidrsubnet(
      var.network.base_cidr,
      var.network.public_subnets_newbits, index
  )]

  private_subnets = [for index in range(var.network.private_subnets_count) :
    cidrsubnet(
      var.network.base_cidr,
      var.network.private_subnets_newbits,
      sum([var.network.public_subnets_count, index])
  )]

  public_subnet_tags  = { "kubernetes.io/role/elb" : 1 }
  private_subnet_tags = { "kubernetes.io/role/internal-elb" : 1 }

  enable_nat_gateway = true
  enable_vpn_gateway = false
}
