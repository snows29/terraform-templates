variable "project_name" {
  type        = string
  description = "Project identifier"
}

variable "env" {
  type        = string
  description = "Target environment name (e.g. dev, stg, prod)"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the EC2 instance will be deployed"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "root_volume_size" {
  type        = number
  description = "Size of the root volume in GB"
  default     = 20
}

variable "root_volume_type" {
  type        = string
  description = "Type of the root EBS volume"
  default     = "gp3"
}