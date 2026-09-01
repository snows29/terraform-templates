variable "project_name" {
  type        = string
  description = "Project identifier"
}

variable "env" {
  type        = string
  description = "Target environment name (e.g. dev, stg, prod)"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where security groups will be created"
}

variable "allowed_ssh_ips" {
  type        = list(string)
  description = "List of CIDR blocks allowed for SSH access"
  default     = []
}

variable "enable_http" {
  type        = bool
  description = "Enable inbound HTTP traffic (port 80)"
  default     = true
}

variable "enable_https" {
  type        = bool
  description = "Enable inbound HTTPS traffic (port 443)"
  default     = true
}