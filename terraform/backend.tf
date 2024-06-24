terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    region  = "eu-central-1"
    profile = "default"
    key     = "demo-nginx-cl-01.terraformstatefile"
    bucket  = "nginxdemobucket1"
  }
}
