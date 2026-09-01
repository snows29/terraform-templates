# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  project_name       = var.project_name
  env                = var.env
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
}

# Security Group Module
module "security_group" {
  source = "../../modules/security_group"

  project_name    = var.project_name
  env             = var.env
  vpc_id          = module.vpc.vpc_id
  allowed_ssh_ips = var.allowed_ssh_ips
}

# EC2 Module
module "ec2" {
  source = "../../modules/ec2"

  project_name       = var.project_name
  env                = var.env
  subnet_id          = module.vpc.public_subnet_id
  security_group_ids = [module.security_group.ec2_sg_id]
  instance_type      = var.instance_type
}