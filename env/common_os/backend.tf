terraform {
  backend "s3" {
    bucket  = "test-terraform"
    key     = "test-terraform-os-common.tfstate"
    region  = "ap-northeast-1"
  }
}
