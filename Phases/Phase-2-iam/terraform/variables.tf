variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "github_repo" {
  description = "GitHub repo for OIDC trust"
  type        = string

  validation {
    condition = can(regex("^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$", var.github_repo))
    error_message = "github_repo must be in owner/repo format (example: mariachiloko/cloud-foundations-aws), not a URL."
  }
}

variable "github_branch" {
  description = "Git branch allowed to assume the OIDC role."
  type        = string
  default     = "main"
}
