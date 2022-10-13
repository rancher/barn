terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.23.0"
    }
  }
  required_version = ">= 1.0"
}
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}
provider "rancher2" {
  api_url    = var.rancher_url
  access_key = var.rancher_access_key
  secret_key = var.rancher_secret_key
}
provider "digitalocean" {
  token = var.digital_ocean_access_token
}