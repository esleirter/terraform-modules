terraform {
  backend "s3" {
    bucket = "esleirter-k8s-infr"
    key    = "caleidos/dev/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.83"
    }
  }
}

provider "aws" {
  region = var.region
}