# ------------------------------------------------------------------------------
# Application Load Balancer
# ------------------------------------------------------------------------------
resource "aws_lb" "main" {
  name               = "${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false # prod環境では true を推奨

  tags = {
    Name        = "${var.env}-alb"
    Environment = var.env
  }
}

# ------------------------------------------------------------------------------
# Target Group (Target Type: IP for ECS Fargate)
# ------------------------------------------------------------------------------
resource "aws_lb_target_group" "main" {
  name        = "${var.env}-ecs-tg"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip" # Required for Fargate (awsvpc network mode)

  health_check {
    enabled             = true
    path                = var.health_check_path
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name        = "${var.env}-ecs-tg"
    Environment = var.env
  }
}

# ------------------------------------------------------------------------------
# HTTP Listener (Port 80)
# ------------------------------------------------------------------------------
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}