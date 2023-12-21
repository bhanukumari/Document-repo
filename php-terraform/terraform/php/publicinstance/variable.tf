
# variable "sub_id" {
#   type = string
#   default = ""
# }

# variable "security_id" {
#   type = string
#   default = ""
# }
# # variable "privatesub_id"{
# #   type = string
# #   default = ""
# # }


# #-----------------------
# # variable "inst_name" {
# #   type    = list(string)
# #   default = ["Instance_pub", "Instance_pvt"]
# # }

# # variable "static" {
# #   type = map(any)
# #   default = {
# #     ami      = "ami-053b0d53c279acc90"
# #     publicip = true
# #     keyname  = "ninja"
# #     itype    = "t2.micro"
# #   }
# # }




# variable "sub_id" {
#   type = string
#   default = ""
# }

# variable "security_id" {
#   type = string
#   default = ""
# }






variable "public_name" {
  type    = string
  default = "bastion"
}
# variable "p_inst_name" {
#   type    = list(string)
#   default = ["Instance_pvt1","Instance_pvt2"]
# }
variable "static" {
  type = map(any)
  default = {
    ami      = "ami-053b0d53c279acc90"
    publicip = true
    keyname  = "web"
    itype    = "t2.medium"
  }
}
# variable "pvt_subnet_id" {
#   type = list(string)
  
# }

variable "sub_id" {
  type = string
 
}

variable "security_id" {
  type    = string
  default = ""
}


#---------------------------------------------------
