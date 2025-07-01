terraform {
  backend "s3" {
    bucket  = "test-terraform"
    key     = "test-terraform-tk-mg.tfstate"
    region  = "ap-northeast-1"
  }
}

