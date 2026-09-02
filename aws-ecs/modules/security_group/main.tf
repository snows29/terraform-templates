# ------------------------------------------------------------------------------
# Security Group for ALB
# ------------------------------------------------------------------------------
resource "aws_security_group" "alb" {
  name        = "${var.env}-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.env}-alb-sg"
    Environment = var.env
  }
}

# ALB Ingress: HTTP (Port 80)
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow inbound HTTP access from configured CIDRs"
  cidr_ipv4         = var.allowed_ingress_cidrs[0] # シンプルにするため先頭要素を指定（必要に応じてループ拡張可）
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# ALB Ingress: HTTPS (Port 443)
resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow inbound HTTPS access from configured CIDRs"
  cidr_ipv4         = var.allowed_ingress_cidrs[0]
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# ALB Egress: Allow traffic to ECS tasks only
resource "aws_vpc_security_group_egress_rule" "alb_to_ecs" {
  security_group_id            = aws_security_group.alb.id
  description                  = "Allow outbound traffic from ALB to ECS tasks"
  referenced_security_group_id = aws_security_group.ecs_task.id
  from_port                    = var.container_port
  to_port                      = var.container_port
  ip_protocol                  = "tcp"
}

# ------------------------------------------------------------------------------
# Security Group for ECS Tasks
# ------------------------------------------------------------------------------
resource "aws_security_group" "ecs_task" {
  name        = "${var.env}-ecs-task-sg"
  description = "Security group for ECS Fargate tasks"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.env}-ecs-task-sg"
    Environment = var.env
  }
}

# ECS Task Ingress: Allow traffic ONLY from ALB Security Group
resource "aws_vpc_security_group_ingress_rule" "ecs_from_alb" {
  security_group_id            = aws_security_group.ecs_task.id
  description                  = "Allow inbound traffic from ALB only"
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = var.container_port
  to_port                      = var.container_port
  ip_protocol                  = "tcp"
}

# ECS Task Egress: Allow outbound internet access (for ECR image pull, CloudWatch Logs, AWS APIs, etc.)
resource "aws_vpc_security_group_egress_rule" "ecs_to_internet" {
  security_group_id = aws_security_group.ecs_task.id
  description       = "Allow all outbound traffic for ECS task (ECR pull, logs, external APIs)"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}