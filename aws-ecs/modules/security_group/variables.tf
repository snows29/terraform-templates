variable "env" {
  type        = string
  description = "Deployment environment"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where security groups will be created"
}

variable "container_port" {
  type        = number
  description = "The port exposed by the image in the ECS container"
  default     = 80
}

variable "allowed_ingress_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks allowed to access the ALB"
  default     = ["0.0.0.0/0"]
}