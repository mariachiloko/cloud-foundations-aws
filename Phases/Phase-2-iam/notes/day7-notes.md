# Day 7 – Terraform IAM + AWS SSO Authentication

## What I Did
- Rebuilt the Phase 2 IAM setup using Terraform
- Created IAM-related Terraform resources in the Phase 2 Terraform folder
- Used AWS SSO / IAM Identity Center instead of long-term local access keys
- Configured Terraform to authenticate through an AWS SSO profile
- Fixed an SSO session naming issue by using a cleaner profile/session setup
- Successfully ran Terraform and confirmed the IAM resources were created

## What I Learned
- Terraform needs AWS credentials, but those credentials do not need to be hardcoded or stored in the repo
- AWS SSO allows local Terraform to use temporary credentials instead of long-term access keys
- GitHub Actions should use OIDC, while local development can use AWS SSO
- Terraform reads all `.tf` files in the same folder as one configuration
- Separate Terraform folders keep each phase isolated and easier to manage

## Key Concepts
- AWS SSO / IAM Identity Center: A secure login method for human users that provides temporary AWS credentials
- OIDC: A secure authentication method for GitHub Actions to access AWS without stored access keys
- Terraform Provider: The part of Terraform that connects to AWS
- Terraform Root Module: A Terraform folder with its own configuration and state
- Temporary Credentials: Short-lived credentials issued after a successful login
- IAM Trust Policy: Defines who can assume a role
- IAM Permission Policy: Defines what actions are allowed after assuming the role

## What I Was Working Through
- I questioned how Terraform could create IAM resources without access keys
- I realized that Terraform still needs credentials, but they can come from AWS SSO instead of static access keys
- I also worked through why Phase 2 should have its own `main.tf` instead of using the Phase 1 networking Terraform files
- I ran into an SSO session error because Terraform could not find the SSO session section, then fixed it by using a cleaner SSO profile/session setup

## Clarification
- Local Terraform and GitHub Actions use different authentication methods:
  - Local Terraform uses AWS SSO
  - GitHub Actions uses OIDC
- IAM resources for Phase 2 belong in the Phase 2 Terraform folder, not the Phase 1 networking folder
- `iam.tf` is used for IAM resources, while `main.tf` can hold shared provider configuration
- File names do not control Terraform behavior; Terraform loads all `.tf` files in the same folder together

## Takeaway
I now understand how to manage IAM resources with Terraform while using AWS SSO for secure local authentication. This avoids hardcoding credentials and gives me a more professional authentication setup that matches real-world cloud engineering practices.