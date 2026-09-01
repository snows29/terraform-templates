variable "aws_region" {
  type        = string
  description = "AWS region for deployment"
  default     = "ap-northeast-1"
}

variable "project_name" {
  type        = string
  description = "Project identifier"
}

variable "env" {
  type        = string
  description = "Target environment name"
  default     = "dev"
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
  description = "Availability zone for public subnet"
  default     = "ap-northeast-1a"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "allowed_ssh_ips" {
  type        = list(string)
  description = "List of CIDR blocks allowed for SSH access"
  default     = []
}