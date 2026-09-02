output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "The DNS name of the ALB to access the ECS service"
}

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "The URL of the ECR repository for image pushes"
}