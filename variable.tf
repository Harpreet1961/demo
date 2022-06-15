/*# variables
variable "account_number" {
  type        = string
  description = "AWS Account Number"
}*/

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for deployments"
}


variable "public_subnets" {
  type        = string
  description = "public subnets"
}

variable "cidr_vpc" {
  type        = string
  description = "cidr of vpc"
}

variable "public_subnet_name" {
  type        = string
  description = "public subnet name"
}

variable "internet_gateway" {
  type        = string
  description = "internet gateway"
}

variable "public_route" {
  type        = string
  description = "public route"
}

variable "vpc_name" {
  type        = string
  description = "vpc name"
}


