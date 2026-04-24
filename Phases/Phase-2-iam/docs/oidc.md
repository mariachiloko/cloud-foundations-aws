# OIDC Authentication (GitHub → AWS)

## Overview

This project uses OpenID Connect (OIDC) to allow GitHub Actions to securely authenticate with AWS without storing access keys.

## Why OIDC

Traditional CI/CD pipelines often store AWS access keys as secrets. This introduces risk because:
- Keys can be leaked
- Keys do not expire automatically
- Keys are difficult to rotate safely

OIDC solves this by:
- Using identity-based authentication
- Issuing temporary credentials
- Eliminating stored secrets

## Architecture Flow

1. GitHub Actions workflow runs
2. GitHub requests an identity token
3. AWS verifies the token using the OIDC provider
4. AWS allows GitHub to assume an IAM role
5. AWS STS issues temporary credentials
6. GitHub uses these credentials to interact with AWS

## IAM Role Design

The IAM role was configured with a trust policy that restricts access to:

- GitHub organization/user: `myusername`
- Specific repository
- Specific branch (main)

This ensures only authorized workflows can assume the role.

## Security Considerations

- No hardcoded credentials in the repository
- Least privilege should be applied (future improvement)
- Trust policy is tightly scoped to prevent unauthorized access

## Future Improvements

- Replace AdministratorAccess with least-privilege policies
- Add Terraform implementation of OIDC provider and role
- Integrate with GitHub Actions workflow for automated deployments

## Takeaway

OIDC provides a secure, modern approach to authentication in CI/CD pipelines by removing the need for long-lived credentials and enforcing strict identity-based access controls.
