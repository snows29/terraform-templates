# ------------------------------------------------------------------------------
# VPC Module
# ------------------------------------------------------------------------------
module "vpc" {
  source = "../../modules/vpc"

  env                  = var.env
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

# ------------------------------------------------------------------------------
# Security Group Module
# ------------------------------------------------------------------------------
module "security_group" {
  source = "../../modules/security_group"

  env            = var.env
  vpc_id         = module.vpc.vpc_id
  container_port = var.container_port
}

# ------------------------------------------------------------------------------
# ECR Module
# ------------------------------------------------------------------------------
module "ecr" {
  source = "../../modules/ecr"

  env             = var.env
  repository_name = var.project_name
}

# ------------------------------------------------------------------------------
# ALB Module
# ------------------------------------------------------------------------------
module "alb" {
  source = "../../modules/alb"

  env               = var.env
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.security_group.alb_security_group_id
  container_port    = var.container_port
}

# ------------------------------------------------------------------------------
# ECS Module
# ------------------------------------------------------------------------------
module "ecs" {
  source = "../../modules/ecs"

  env                        = var.env
  cluster_name               = "${var.project_name}-cluster"
  service_name               = "${var.project_name}-web"
  private_subnet_ids         = module.vpc.private_subnet_ids
  ecs_task_security_group_id = module.security_group.ecs_task_security_group_id
  target_group_arn           = module.alb.target_group_arn
  container_image            = var.dummy_container_image
  container_port             = var.container_port
  cpu                        = "256"
  memory                     = "512"
  desired_count              = 2
}