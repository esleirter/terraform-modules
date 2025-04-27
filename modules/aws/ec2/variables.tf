locals {
  name      = lower("${var.environment}-${var.project}-ec2")

  default_tags = {
    Project     = var.project
    Environment = var.environment
    Region      = var.region
  }

  all_tags = merge(local.default_tags, var.tags)
}

variable "create_private_key" {
  type        = bool
  description = "Determines whether a private key will be created"
  default     = true
}

variable "project" {
  type        = string
  description = "Name/Code of the project"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, qa, prod)"
}

variable "instance_names" {
  type        = list(string)
  description = "List of instance name suffixes. One instance will be created per value. Ex: [\"01\", \"02\"]"
  default     = ["01"]
}

variable "ami" {
  type        = string
  description = "AMI ID to use for the EC2 instance"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "SSH key pair name for accessing the EC2 instance"
  default     = ""
  validation {
    condition     = length(var.key_name) > 0
    error_message = "You must provide a non-empty key_name."
  }
}

variable "subnet_id" {
  type        = string
  description = "subnet id where the ec2 instance needs to be created"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public IP address with an instance in a VPC"
  default     = false
}

variable "monitoring" {
  type        = bool
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = true
}

variable "tags" {
  description = "Additional custom tags to be merged with default tags"
  type        = map(string)
  default     = {}
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the instance"
}

variable "region" {
  type    = string
  default = "us-east-1"
}
