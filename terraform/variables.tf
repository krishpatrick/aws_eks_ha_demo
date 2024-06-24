variable "profile" {
  type    = string
  default = "default"
}

variable "main-region" {
  type    = string
  default = "eu-central-1"
}

variable "cluster_name" {
  default = "demo-nginx-cl-01"
}

variable "cluster_version" {
  default = "1.30"
}
