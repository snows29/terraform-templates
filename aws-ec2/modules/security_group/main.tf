resource "aws_security_group" "ec2" {
  name        = "${var.project_name}-${var.env}-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  # Inbound HTTP rule (Optional)
  dynamic "ingress" {
    for_each = var.enable_http ? [1] : []
    content {
      description = "Allow HTTP from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Inbound HTTPS rule (Optional)
  dynamic "ingress" {
    for_each = var.enable_https ? [1] : []
    content {
      description = "Allow HTTPS from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Inbound SSH rule (Only if allowed_ssh_ips is specified)
  dynamic "ingress" {
    for_each = length(var.allowed_ssh_ips) > 0 ? [1] : []
    content {
      description = "Allow SSH access from specified CIDR blocks"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.allowed_ssh_ips
    }
  }

  # Outbound rule (Allow all traffic)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.env}-ec2-sg"
  }
}