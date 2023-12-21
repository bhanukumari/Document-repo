
variable "private_name" {
  type    = list(string)
  default = ["jenkins","jenkins"]
}
variable "static" {
  type = map(any)
  default = {
    ami      = "ami-053b0d53c279acc90"
    publicip = true
    keyname  = "web"
    itype    = "t2.micro"
  }
}
variable "privatesub_id" {
  type = list(string)
  
}

# variable "pub_subnet_id" {
#   type = string
#   default = ""
# }

variable "security_id" {
  type    = string
  default = ""
}
