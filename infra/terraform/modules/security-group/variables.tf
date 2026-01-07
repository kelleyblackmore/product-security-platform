variable "name" { type = string }
variable "description" { type = string }
variable "vpc_id" { type = string }
variable "tags" { type = map(string); default = {} }

variable "ingress" {
  type = list(object({
    cidr      = string
    from_port = number
    to_port   = number
    protocol  = string
  }))
  default = []
}

variable "egress" {
  type = list(object({
    cidr      = string
    from_port = number
    to_port   = number
    protocol  = string
  }))
  default = [{
    cidr      = "0.0.0.0/0"
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }]
}
