terraform {
  backend "s3" {
    bucket  = "test-terraform"
    key     = "test-terraform-tk-ap-B.tfstate"
    region  = "ap-northeast-1"
  }
}