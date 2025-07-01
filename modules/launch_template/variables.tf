#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_prefix" {
  type = string
}


#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#サブネット
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "subnet_ids" {
  type = map(string)

}
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#IAM
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

variable "ec2_profile_name" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Key Pair
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "keypair_name" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Security Group
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "sg_ids_output" {
  type = map(string)
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#Launch Template
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_lt_1" {
  type = string
}

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#AMI
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "ami_id" {
  type = string
}