terraform {
  backend "s3" {
    encrypt = true
    bucket = "tf-bind9-statebucket"
    key = "bind9-terraform/terraform.tfstate"
    dynamodb_table = "tf-bind9-state-lock"
    region = "eu-west-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "3.2.3"
    }
  }

}

provider "dns" {
  update {
    server        = "172.16.1.43"
    key_name      = "tsig-key."
    key_algorithm = "hmac-sha256"
    key_secret    = var.tsig_key
  }
}

provider "aws" {
}
