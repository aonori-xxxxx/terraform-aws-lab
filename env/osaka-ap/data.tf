data "terraform_remote_state" "common" {
  backend = "s3"
  config = {
    bucket  = "test-terraform"
    key     = "test-terraform-tk-common.tfstate"
    region  = "ap-northeast-1"
  }
}

data "terraform_remote_state" "common_os" {
  backend = "s3"
  config = {
    bucket  = "test-terraform"
    key     = "test-terraform-os-common.tfstate"
    region  = "ap-northeast-1"
  }
}