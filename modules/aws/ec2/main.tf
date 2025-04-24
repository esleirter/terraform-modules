module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  # Name of the instances
  for_each  = toset(var.instance_names)
  name      = "${local.name}-${each.key}"

  # Instance Configuration
  instance_type = var.instance_type
  ami           = var.ami
  key_name      = var.key_name
  monitoring    = var.monitoring

  # Networking configuration
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  # Tags
  tags = local.all_tags
}