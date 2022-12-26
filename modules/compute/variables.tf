variable "enviroment" {
  type        = string
}

variable "instance_type" {
  description = "instance type"
  type        = string
  default = "t2.micro"
}

variable "instances_per_subnet" {
  description = "instances per subnet"
  type        = number
}

variable "tags" {
  description = "Tags to set on the computed variables."
  type        = map(string)
  default     = {
    created_by = "liz.asraf"
    managed_by = "terraform"
  }
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
  default     = "lizasraf"
}

variable "security_groups" {
  description = "security_groups"
}

variable "subnet" {
  description = "subnet"
  type        = list
}

variable "aws_iam_instance_profile" {
  description = "iam profile for the instance"
  type        = string
}

variable "public_subnets_per_vpc" {
  description = "public subnets per vpc"
  type        = number
}
/* variable "privet-key" {
  type        = string
} */