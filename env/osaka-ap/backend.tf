terraform {
  backend "s3" {
    bucket  = "test-terraform"
    key     = "test-terraform-os-ap.tfstate"
    region  = "ap-northeast-1"
  }
}