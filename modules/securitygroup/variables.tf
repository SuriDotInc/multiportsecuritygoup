variable "vpc_id" {
  type        = string
  description = "The VPC ID that the security group belongs to"
}


variable "tags" {
  type        = map(string)
  description = "security group tags"
  default     = {}
}

variable "sgname" {
  type        = string
  description = "The Security group name"
}

variable "description" {
  default = "Default Security group (egress only)"
  type    = string
}

variable "multi_port_sg" {
  default     = []
  type        = list(map(string))
  description = "Multiport and multi protocol  security group"
}
