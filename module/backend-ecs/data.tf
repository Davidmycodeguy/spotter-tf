data "aws_ecr_repository" "service" {
  name = var.ecr_repo_name
  depends_on=[aws_ecr_repository.spotter-frontend-repository]
}