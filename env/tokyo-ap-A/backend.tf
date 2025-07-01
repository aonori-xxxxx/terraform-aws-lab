terraform {
  backend "s3" {
    bucket  = "test-terraform"
    key     = "test-terraform-tk-ap-A.tfstate"
    region  = "ap-northeast-1"
  }
}