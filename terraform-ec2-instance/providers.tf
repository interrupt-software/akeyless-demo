terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    akeyless = {
      version = ">= 1.0.0"
      source  = "akeyless-community/akeyless"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "akeyless" {
  api_gateway_address = "https://api.akeyless.io"

  email_login {
    admin_email    = var.akeyless_admin_email
    admin_password = var.akeyless_admin_password
  }
}