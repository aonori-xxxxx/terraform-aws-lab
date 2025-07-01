terraform {
  backend "s3" {
    bucket  = "test-terraform"
    key     = "test-terraform-tk-common.tfstate"
    region  = "ap-northeast-1"
  }
}
