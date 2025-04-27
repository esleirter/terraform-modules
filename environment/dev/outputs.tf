output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_instances_private_key_pem" {
  description = "Private key to SSH into the EC2 instance"
  value       = module.ec2_public.private_key_pem
  sensitive   = true
}

output "private_intances_private_key_pem" {
  description = "Private key to SSH into the EC2 instance"
  value       = module.ec2_private.private_key_pem
  sensitive   = true
}

