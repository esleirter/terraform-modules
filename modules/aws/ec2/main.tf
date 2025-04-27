module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"
  version = "2.0.3"
  
  # Key Pair Configuration
  key_name           = "${local.name}-${var.key_name}"
  create_private_key = var.create_private_key

  # Tags
  tags = local.all_tags
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  # Name of the instances
  for_each  = toset(var.instance_names)
  name      = "${local.name}-${each.key}"

  # Instance Configuration
  instance_type = var.instance_type
  ami           = var.ami
  key_name      = module.key_pair.key_pair_name
  monitoring    = var.monitoring

  # Networking configuration
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address

  # Tags
  tags = local.all_tags
}