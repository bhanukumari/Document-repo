variable "vpc_id" {
    type = string

  default = ""
}

# variable "privatesub_id" {
#     type = string

#   default = ""
# }
variable "natgate_id" {
    type = string

  default = ""
}

# variable "rt_name1" {
#   type    = string
#   default = "ninja-rt-pvt"
# }

variable "rt_cidr" {
  type    = string
  default = "0.0.0.0/0"
}