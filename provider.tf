# Configure the AWS Provider
provider "aws" {
  region    = var.region
}


# Declare the data source
data "aws_availability_zones" "aws-AZs" {
  state = var.state
  }


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.50"
    }
  }
}
