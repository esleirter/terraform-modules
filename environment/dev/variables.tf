variable "region" {
  type = string
  default = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment code. Only 'prod' (production), 'qa' (pre-production), or 'dev' (development) are allowed."

  validation {
    condition     = can(regex("^(prod|qa|dev)$", var.environment))
    error_message = "The 'environment' variable must be one of: 'prod', 'qa', or 'dev'."
  }
}

variable "vpc_cidr" {
  type        = string
  description = "vpc cidr block to be used"
  default     = "10.0.0.0/16"
}