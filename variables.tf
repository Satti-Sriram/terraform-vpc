variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones / public subnets to create"
  type        = number
  default     = 2
}

variable "public_subnet_newbits" {
  description = "Number of new bits to add to the VPC mask to create public subnets (e.g. 8 to go from /16 to /24)"
  type        = number
  default     = 8
}

variable "name" {
  description = "Base name tag for resources"
  type        = string
  default     = "terraform-vpc"
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}
