variable "project_name" {
  type        = string
  description = "Project identifier"
}

variable "env" {
  type        = string
  description = "Target environment name"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone for the subnet"
}