# 東京リージョン用
provider "aws" {
  region  = "ap-northeast-1"
}

# 大阪リージョン用
provider "aws" {
  alias   = "osaka"
  region  = "ap-northeast-3"
}
