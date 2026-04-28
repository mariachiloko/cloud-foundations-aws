#############################################
# OIDC Provider (GitHub → AWS Trust)
#############################################

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}

#############################################
# IAM Role for GitHub Actions
#############################################

resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          },
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_repo}:*"
          }
        }
      }
    ]
  })
}

#############################################

# IAM Policy (Scoped Permissions for Terraform IAM Phase)

#############################################

resource "aws_iam_policy" "terraform_policy" {

  name = "terraform-iam-phase-deploy-policy"

  description = "Scoped permissions for Terraform to manage IAM resources used in Phase 2."

  policy = jsonencode({

    Version = "2012-10-17",

    Statement = [

      {

        Sid = "ManagePhase2IamResources"

        Effect = "Allow"

        Action = [

          "iam:CreateRole",

          "iam:GetRole",

          "iam:UpdateRole",

          "iam:DeleteRole",

          "iam:ListRoles",

          "iam:CreatePolicy",

          "iam:GetPolicy",

          "iam:GetPolicyVersion",

          "iam:ListPolicyVersions",

          "iam:DeletePolicy",

          "iam:CreatePolicyVersion",

          "iam:DeletePolicyVersion",

          "iam:AttachRolePolicy",

          "iam:DetachRolePolicy",

          "iam:ListAttachedRolePolicies",

          "iam:CreateOpenIDConnectProvider",

          "iam:GetOpenIDConnectProvider",

          "iam:DeleteOpenIDConnectProvider",

          "iam:UpdateOpenIDConnectProviderThumbprint",

          "iam:ListOpenIDConnectProviders",

          "iam:TagRole",

          "iam:TagPolicy",

          "iam:UntagRole",

          "iam:UntagPolicy"

        ]

        Resource = "*"

      }

    ]

  })

}

#############################################
# Attach Policy to Role
#############################################

resource "aws_iam_role_policy_attachment" "github_attach" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.terraform_policy.arn
}