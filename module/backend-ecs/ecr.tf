resource "aws_ecr_repository" "spotter-frontend-repository" {
  name                 = var.ecr_repo_name
}

