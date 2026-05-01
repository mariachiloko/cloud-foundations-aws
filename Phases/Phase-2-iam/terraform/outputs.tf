output "github_actions_role_name" {
  description = "Name of the IAM role assumed by GitHub Actions through OIDC."
  value       = aws_iam_role.github_actions_role.name
}

output "github_actions_role_arn" {
  description = "ARN of the IAM role assumed by GitHub Actions through OIDC."
  value       = aws_iam_role.github_actions_role.arn
}

output "github_oidc_provider_arn" {
  description = "ARN of the GitHub OIDC provider configured in AWS IAM."
  value       = aws_iam_openid_connect_provider.github.arn
}

output "github_oidc_expected_sub" {
  description = "Expected OIDC sub claim for GitHub Actions."
  value       = "repo:${var.github_repo}:ref:refs/heads/${var.github_branch}"
}
