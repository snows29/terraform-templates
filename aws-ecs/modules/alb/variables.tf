variable "env" {
  type        = string
  description = "Deployment environment (e.g., dev, stg, prod)"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the ALB and Target Group will be created"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs to attach to the ALB"
}

variable "security_group_id" {
  type        = string
  description = "The ID of the ALB Security Group"
}

variable "container_port" {
  type        = number
  description = "Port on which the ECS container is listening"
  default     = 80
}

variable "health_check_path" {
  type        = string
  description = "HTTP path for ALB health check"
  default     = "/"
}