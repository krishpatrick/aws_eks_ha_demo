provider "aws" {
  region = "eu-central-1"
}

variable "cluster_name" {
  default = "demo-nginx-cl-01"
}

variable "cluster_version" {
  default = "1.30"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
