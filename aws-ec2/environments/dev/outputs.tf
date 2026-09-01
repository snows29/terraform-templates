output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of the created VPC"
}

output "ec2_instance_id" {
  value       = module.ec2.instance_id
  description = "ID of the created EC2 instance"
}

output "ec2_public_ip" {
  value       = module.ec2.public_ip
  description = "Public IP address of the EC2 instance"
}