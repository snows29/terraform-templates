output "instance_id" {
  value       = aws_instance.main.id
  description = "ID of the EC2 instance"
}

output "public_ip" {
  value       = aws_instance.main.public_ip
  description = "Public IP address of the EC2 instance"
}

output "private_ip" {
  value       = aws_instance.main.private_ip
  description = "Private IP address of the EC2 instance"
}