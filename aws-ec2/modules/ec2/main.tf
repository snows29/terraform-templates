# Fetch the latest Amazon Linux 2023 (AL2023) AMI
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# IAM Role for EC2 Systems Manager (SSM)
resource "aws_iam_role" "ssm_role" {
  name = "${var.project_name}-${var.env}-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-${var.env}-ec2-ssm-role"
  }
}

# Attach AmazonSSMManagedInstanceCore Policy to IAM Role
resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${var.project_name}-${var.env}-ec2-ssm-profile"
  role = aws_iam_role.ssm_role.name
}

# EC2 Instance
resource "aws_instance" "main" {
  ami                  = data.aws_ami.al2023.id
  instance_type        = var.instance_type
  subnet_id            = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    encrypted             = true
    delete_on_termination = true

    tags = {
      Name = "${var.project_name}-${var.env}-ec2-root-volume"
    }
  }

  tags = {
    Name = "${var.project_name}-${var.env}-ec2"
  }
}