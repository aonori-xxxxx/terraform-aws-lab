terraform {
  backend "s3" {
    bucket = "test-terraform"
    key    = "test-terraform-tk-so.tfstate"
    region = "ap-northeast-1"
  }
}
