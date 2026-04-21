# OIDC Authentication & Debugging (GitHub → AWS)

## Overview

This project implements secure authentication between GitHub Actions and AWS using OpenID Connect (OIDC) and IAM roles.

Instead of storing AWS access keys, GitHub assumes an IAM role using a trusted identity, and AWS issues temporary credentials via STS.

## Initial Issue

The GitHub Actions workflow failed with:

"Not authorized to perform sts:AssumeRoleWithWebIdentity"

This indicated that AWS received the OIDC token but rejected it due to a mismatch in the IAM trust policy.

## Root Cause

The IAM role trust policy had an incorrect `sub` condition.

Incorrect format:
repo:mariachiloko/https://github.com/mariachiloko/cloud-foundations-aws:ref:refs/heads/main

GitHub does NOT include the repository URL in the OIDC subject.

Correct format:
repo:mariachiloko/cloud-foundations-aws:ref:refs/heads/main

## Resolution

The trust policy was updated to match GitHub’s actual OIDC subject format exactly.

Final trust policy conditions:

- aud: sts.amazonaws.com
- sub: repo:mariachiloko/cloud-foundations-aws:ref:refs/heads/main

After this change, the workflow successfully assumed the IAM role.

## Validation

The workflow executed:

aws sts get-caller-identity

Result:
- Confirmed role assumption
- Verified AWS account access via temporary credentials

## Debugging Improvements

To improve future troubleshooting, a debug step was added to the workflow to output:

- GitHub repository name
- Branch reference
- Expected OIDC subject format

## Workflow Updates

GitHub Actions were updated to avoid future runtime deprecations:

- actions/checkout upgraded to v6
- aws-actions/configure-aws-credentials upgraded to v6

## Security Design

- No long-lived AWS credentials stored in GitHub
- Access controlled via IAM role and trust policy
- Trust policy restricted to:
  - Specific GitHub user
  - Specific repository
  - Specific branch

## Key Lesson

OIDC authentication failures are most commonly caused by incorrect trust policy conditions.

The most critical value to verify is:
token.actions.githubusercontent.com:sub

This value must exactly match GitHub’s OIDC token format.

## Takeaway

This implementation demonstrates a secure, modern CI/CD authentication pattern using OIDC and IAM roles, along with real-world debugging of trust policy mismatches.
