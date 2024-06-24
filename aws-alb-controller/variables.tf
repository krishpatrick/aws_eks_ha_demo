variable "profile" {
  type    = string
  default = "default"
}

variable "main-region" {
  type    = string
  default = "eu-central-1"
}

variable "cluster_name" {
  default = "demo-nginx-cl-02"
}

variable "oidc_provider_arn" {
  default = "arn:aws:iam::230951218756:oidc-provider/oidc.eks.eu-central-1.amazonaws.com/id/FD0C0FBAE3791D3007718D545332253C"
}

variable "cluster_version" {
  default = "1.30"
}

################################################################################
# General Variables from root module
################################################################################

variable "vpc_id" {
  description = "VPC ID which Load balancers will be  deployed in"
  default = "vpc-05cf0223857616764"
}
