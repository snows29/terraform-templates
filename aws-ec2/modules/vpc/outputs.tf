output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the created VPC"
}

output "vpc_cidr" {
  value       = aws_vpc.main.cidr_block
  description = "CIDR block of the created VPC"
}

output "public_subnet_id" {
  value       = aws_subnet.public.id
  description = "ID of the created public subnet"
}