#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#共通
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
variable "name_prefix" {
  type = string
}
variable "region" {
  type = string  
}

variable "traffice_dial_percentage" {
  type = number
  default = 100
}