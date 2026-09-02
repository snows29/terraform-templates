output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The ID of the ALB Security Group"
}

output "ecs_task_security_group_id" {
  value       = aws_security_group.ecs_task.id
  description = "The ID of the ECS Task Security Group"
}