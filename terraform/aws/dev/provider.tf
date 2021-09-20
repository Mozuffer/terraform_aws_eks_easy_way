terraform {
  backend "s3" {
    bucket = "aws0003-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

data "aws_availability_zones" "available" {

}