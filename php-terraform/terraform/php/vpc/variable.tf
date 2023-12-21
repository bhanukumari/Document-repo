variable "vpc_cidr" {
    type = string

  default = "10.0.0.0/16"
}

variable "vpc" {
    type = string
    default = "vpc_jenkins"
}
