data "terraform_remote_state" "common" {
  backend = "s3"
  config = {
    bucket  = "test-terraform"
    key     = "test-terraform-tk-common.tfstate"
    region  = "ap-northeast-1"
  }
}

data "terraform_remote_state" "tk_ap_A" {
  backend = "s3"
  config = {
    bucket  = "test-terraform"
    key     = "test-terraform-tk-ap-A.tfstate"
    region  = "ap-northeast-1"
  }
}

data "terraform_remote_state" "tk_ap_B" {
  backend = "s3"
  config = {
    bucket  = "test-terraform"
    key     = "test-terraform-tk-ap-B.tfstate"
    region  = "ap-northeast-1"
  }
}

data "terraform_remote_state" "os_ap" {
  backend = "s3"
  config = {
    bucket  = "test-terraform"
    key     = "test-terraform-os-ap.tfstate"
    region  = "ap-northeast-1"
  }
}
