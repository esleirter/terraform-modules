locals {
  name      = lower("${var.environment}-${var.project}")
  vpc_name  = lower("${local.name}-vpc")
  acl_name  = lower("${local.name}-acl-default")
  rt_name   = lower("${local.name}-rt-default")
  sg_name   = lower("${local.name}-sg-default")

  default_tags = {
    Project     = var.project
    Environment = var.environment
    Region      = var.region
  }

  all_tags = merge(local.default_tags, var.tags)
}

variable "project" {
  type        = string
  description = "Name/Code of the project"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, qa, prod)"
}

variable "azs" {
  description = "List of Availability Zones (AZs) to use in the region. Ex: [\"us-east-1a\", \"us-east-1b\", \"us-east-1c\"]"
  type        = list(string)

}

variable "vpc_cidr" {
  type        = string
  description = "Primary CIDR block for the VPC. Must be a valid IPv4 CIDR, e.g. 10.0.0.0/16."

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "The 'vpc_cidr' variable must be a valid IPv4 CIDR block, such as '10.0.0.0/16'."
  }
}

variable "public_subnets" {
  description = "List of public subnet CIDRs. One per AZ. Example: [\"10.0.1.0/24\", \"10.0.2.0/24\"]"
  type        = list(string)

  validation {
    condition = alltrue([
      for cidr in var.public_subnets : can(cidrhost(cidr, 0))
    ])
    error_message = "All values in 'public_subnets' must be valid IPv4 CIDR blocks."
  }
}

variable "private_subnets" {
  description = "List of private subnet CIDRs. One per AZ. Example: [\"10.0.101.0/24\", \"10.0.102.0/24\"]"
  type        = list(string)

  validation {
    condition = alltrue([
      for cidr in var.private_subnets : can(cidrhost(cidr, 0))
    ])
    error_message = "All values in 'private_subnets' must be valid IPv4 CIDR blocks."
  }
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone."
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "additional_public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

variable "additional_private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}

variable "create_igw" {
  description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them."
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "tags" {
  description = "Additional custom tags to be merged with default tags"
  type        = map(string)
  default     = {}
}

variable "region" {
  type = string
  default = "us-east-1"
}
