variable "cidr_subnet" {
    type = string

  default = "10.0.1.0/24"
}

variable "subnet_zone" {
    type = string

  default = "us-east-1a"
}
variable "vpc_id" {
    type = string

  default = ""
}

variable "sub_name" {
    type = string
    default = "subnet_public"
}