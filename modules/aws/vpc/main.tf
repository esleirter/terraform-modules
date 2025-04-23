module "vpc_with_subnets" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  # Resources names
  name                          = local.vpc_name
  default_network_acl_name      = local.acl_name
  default_route_table_name      = local.rt_name
  default_security_group_name   = local.sg_name

  # availability zones
  azs             = var.azs

  # vpc cidr
  cidr = var.vpc_cidr

  # public and private subnets
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  # create nat gateways
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  # enable dns hostnames and support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  # tags for public, private subnets and vpc
  tags = local.all_tags
  public_subnet_tags  = var.additional_public_subnet_tags
  private_subnet_tags = var.additional_private_subnet_tags

  # create internet gateway
  create_igw       = var.create_igw
  instance_tenancy = var.instance_tenancy

}