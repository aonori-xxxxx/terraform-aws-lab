terraform {
  required_version = ">=1.9.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.81.0"
    }
  }
}

# 東京リージョン用
provider "aws" {
  region = "ap-northeast-1"
}


# 大阪リージョン用
provider "aws" {
  alias   = "osaka"
  region  = "ap-northeast-3"
}