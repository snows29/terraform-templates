variable "env" {
  type        = string
  description = "Deployment environment"
}

variable "repository_name" {
  type        = string
  description = "Name of the ECR repository"
}

variable "image_tag_mutability" {
  type        = string
  description = "The tag mutability setting for the repository (MUTABLE or IMMUTABLE)"
  default     = "MUTABLE"
}

variable "untagged_image_retention_days" {
  type        = number
  description = "Number of days to retain untagged images before deletion"
  default     = 7
}

variable "tagged_image_max_count" {
  type        = number
  description = "Maximum number of tagged images to retain"
  default     = 10
}