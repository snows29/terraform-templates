output "cluster_arn" {
  value       = aws_ecs_cluster.main.arn
  description = "The ARN of the ECS Cluster"
}

output "cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "The name of the ECS Cluster"
}

output "service_name" {
  value       = aws_ecs_service.main.name
  description = "The name of the ECS Service"
}

output "task_execution_role_arn" {
  value       = aws_iam_role.execution.arn
  description = "The ARN of the Task Execution IAM Role"
}

output "task_role_arn" {
  value       = aws_iam_role.task.arn
  description = "The ARN of the Task IAM Role"
}