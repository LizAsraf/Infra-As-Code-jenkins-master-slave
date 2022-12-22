variable "enviroment" {
  type        = string
}

variable "public_subnets_per_vpc" {
  description = "public subnets per vpc"
  type        = number
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "rt_cidr" {
  description = "CIDR block for rt"
  type        = string
  default     = "0.0.0.0/0"
}

variable "tags" {
  description = "Tags to set on the network variables."
  type        = map(string)
  default     ={
    createdby = "liz.asraf"
    managedby = "terraform"
  }
}