variable "instance_type" {
  description = "instance type"
  type        = string
}

variable "instances_per_subnet" {
  description = "instances per subnet"
  type        = number

}

variable "tags" {
  description = "Tags to set on the computed variables."
  type        = map(string)
}

variable "ami-slave" {
  description = "image to create instance"
  type        = string
}

variable "ami-master" {
  description = "image to create instance"
  type        = string
}

variable "keyname" {
  description = "key for the aws"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
}

variable "public_subnets_per_vpc" {
  description = "public subnets per vpc"
  type        = number
}

variable "enviroment" {
  type        = string
}

variable "region" {
  type        = string
}
/* 
variable "privet-key" {
  type        = string
} */
