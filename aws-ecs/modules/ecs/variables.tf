variable "env" {
  type        = string
  description = "Deployment environment (e.g., dev, stg, prod)"
}

variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
}

variable "service_name" {
  type        = string
  description = "Name of the ECS service"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for ECS tasks"
}

variable "ecs_task_security_group_id" {
  type        = string
  description = "Security Group ID for ECS tasks"
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the ALB Target Group to register tasks with"
}

variable "container_image" {
  type        = string
  description = "Docker image URI (e.g., ECR repository URL + tag)"
}

variable "container_port" {
  type        = number
  description = "Port exposed by the container"
  default     = 80
}

variable "cpu" {
  type        = string
  description = "CPU units for the task (e.g., '256' for 0.25 vCPU)"
  default     = "256"
}

variable "memory" {
  type        = string
  description = "Memory for the task in MiB (e.g., '512')"
  default     = "512"
}

variable "desired_count" {
  type        = number
  description = "Number of instances of the task to run"
  default     = 2
}