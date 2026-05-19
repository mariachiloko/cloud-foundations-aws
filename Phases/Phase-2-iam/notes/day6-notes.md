# Day 6 – OIDC (GitHub → AWS Authentication)

## What I Did
- Created an OIDC identity provider in AWS for GitHub
- Created an IAM role for GitHub Actions
- Configured a trust relationship between AWS and GitHub
- Restricted access to my specific GitHub repository and branch
- Attached permissions to allow GitHub to interact with AWS

## What I Learned
- OIDC allows secure authentication without storing AWS access keys
- GitHub can assume an IAM role using temporary credentials
- Trust policies define who is allowed to assume a role
- AWS uses STS (Security Token Service) to generate temporary credentials
- Restricting by repo and branch is critical for security

## Key Concepts

### OIDC (OpenID Connect)
- A way for GitHub to prove its identity to AWS
- Eliminates the need for long-lived credentials

### IAM Role
- A set of permissions that GitHub can assume
- Used instead of IAM users for automation

### Trust Policy
- Defines WHO can assume the role
- In this case: GitHub repository + branch

### STS (Security Token Service)
- Issues temporary credentials
- Credentials expire automatically

## What Was Important Today
- Do NOT store AWS access keys in GitHub
- Always restrict OIDC roles to:
  - Specific GitHub organization/user
  - Specific repository
  - Specific branch

## Takeaway
I learned how modern CI/CD pipelines securely authenticate to AWS using OIDC and IAM roles instead of access keys. This is a best practice used in real-world cloud environments.


---

## Debugging OIDC Failure (Real Issue)

### What Happened
- GitHub Actions workflow failed with:
  sts:AssumeRoleWithWebIdentity (Not authorized)

### Root Cause
- IAM trust policy had incorrect `sub` claim format
- Used a GitHub URL instead of proper OIDC subject format

Incorrect:
repo:mariachiloko/https://github.com/... ❌

Correct:
repo:mariachiloko/cloud-foundations-aws:ref:refs/heads/main ✅

### What I Fixed
- Updated trust policy `sub` condition to match GitHub’s actual OIDC token format exactly
- Kept `aud` as: sts.amazonaws.com

### Validation
- Ran workflow again
- Used:
  aws sts get-caller-identity
- Confirmed role was successfully assumed

### Additional Improvements
- Added debug step in workflow to print:
  - GitHub repository
  - Branch reference
  - Expected OIDC subject

### Key Lesson
- OIDC failures usually come from trust policy mismatches
- The most important value to check is:
  token.actions.githubusercontent.com:sub
- This must match EXACTLY (org, repo, branch)

### Takeaway (Updated)
I learned how to debug real-world OIDC authentication issues by fixing trust policy mismatches and validating identity claims between GitHub and AWS.
