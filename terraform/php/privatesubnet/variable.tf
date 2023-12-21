variable "private_subnet_cidr" {
  type = list(string)
  default = ["10.0.5.0/24","10.0.7.0/24" , "10.0.8.0/24"]
}

variable "private-az_zone" {
  type = list(string)
  default = ["us-east-1a" , "us-east-1b" , "us-east-1b"]
}
variable "private-subnet-name" {
  type = list(string)
  default = ["pvt-sub-1a" , "pvt-sub-1b", "pvt-sub2-1b"]
  
}
variable "vpc_id" {
    type = string
    default = ""
}