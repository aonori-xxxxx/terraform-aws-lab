terraform {
  required_version = ">=1.9.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.81.0"
    }
  }
}

# 大阪リージョン用
provider "aws" {
  region  = "ap-northeast-3"
}

# 東京リージョン用
provider "aws" {
  alias   = "tokyo"
  region  = "ap-northeast-1"
}
