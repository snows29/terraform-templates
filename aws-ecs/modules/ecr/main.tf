# ------------------------------------------------------------------------------
# ECR Repository
# ------------------------------------------------------------------------------
resource "aws_ecr_repository" "main" {
  name                 = "${var.env}-${var.repository_name}"
  image_tag_mutability = var.image_tag_mutability

  # Automatically scan images for vulnerabilities upon push
  image_scanning_configuration {
    scan_on_push = true
  }

  # KMS encryption configuration (using default AWS managed key)
  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = "${var.env}-${var.repository_name}"
    Environment = var.env
  }
}

# ------------------------------------------------------------------------------
# ECR Lifecycle Policy
# ------------------------------------------------------------------------------
resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Remove untagged images older than specified days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = var.untagged_image_retention_days
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Keep only a limited number of tagged images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v", "release", "latest", "dev", "stg", "prod"] # 一般的なタグプレフィックス指定（すべてのタグ対象なら "any" を使用）
          countType     = "imageCountMoreThan"
          countNumber   = var.tagged_image_max_count
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}