module "vpc" {
  source = "../../modules/aws/vpc"

  project         = "myapp"
  environment     = var.environment

  vpc_cidr        = var.vpc_cidr
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

module "ec2_private" {
  source = "../../modules/aws/ec2"

  project         = "myapp"
  environment     = var.environment

  instance_names = ["priv-001"]
  ami = "ami-0e449927258d45bc4"
  key_name = "private-instances"
  
  subnet_id = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.vpc.default_security_group_id]

  depends_on = [ module.vpc ]
}

module "ec2_public" {
  source = "../../modules/aws/ec2"

  project         = "myapp"
  environment     = var.environment

  instance_names = ["public-001"]
  ami = "ami-0e449927258d45bc4"
  key_name = "public-instances"
  
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  associate_public_ip_address = true

  depends_on = [ module.vpc ]
}