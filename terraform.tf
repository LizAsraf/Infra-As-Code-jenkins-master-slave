terraform {
  /* backend "s3" {
    bucket = "jenkins"
    key = "jenkins/terraform.tfstate"
    region = "eu-north-1"
  } */
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.32.0"
    }   
  }
  required_version = "<= 4.32.0"
}

provider "aws" {
  region = var.region
}
