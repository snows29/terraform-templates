variable "aws_region" {
  type        = string
  description = "AWS Region to deploy resources"
  default     = "ap-northeast-1"
}

variable "env" {
  type        = string
  description = "Deployment environment name"
  default     = "dev"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "my-app"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones for subnets"
  default     = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "container_port" {
  type        = number
  description = "Application container port"
  default     = 80
}

# テスト表示用のダミーコンテナイメージ（NGINX）
variable "dummy_container_image" {
  type        = string
  description = "Initial container image for testing before first ECR push"
  default     = "public.ecr.aws/nginx/nginx:latest"
}