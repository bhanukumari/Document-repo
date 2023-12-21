variable "ports" {
  type = list(number)
  default = [22, 80, 443, 5601 , 9200, 8080]
}
variable "vpc_id" {
  type = string
  default = ""
}

variable "name-sg" {
  type    = string
  default = "elastic-sg"
}

variable "cidr_blocks" {
  type    = string
  default = "0.0.0.0/0"
}