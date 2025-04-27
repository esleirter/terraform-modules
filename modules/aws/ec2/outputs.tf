# Key Pair Outputs
output "key_pair_id" {
  description = "The key pair ID"
  value       = module.key_pair.key_pair_id
}

output "key_pair_name" {
  description = "The key pair name"
  value       = module.key_pair.key_pair_name
}

output "private_key_pem" {
  description = "Private key to SSH into the EC2 instance"
  value       = module.key_pair.private_key_pem
  sensitive   = true
}

# EC2 Outputs

output "ec2_ids" {
  description = "IDs of the created EC2 instances"
  value = {
    for instance_key, instance_module in module.ec2_instance :
    instance_key => instance_module.id
  }
}

output "ec2_private_ips" {
  description = "Private IP addresses of the EC2 instances"
  value = {
    for instance_key, instance_module in module.ec2_instance :
    instance_key => instance_module.private_ip
  }
}
