provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

variable "region" {
  type = string
}