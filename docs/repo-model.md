# Repository Model

## Public Repository

This repository contains the material that is safe and useful to publish:

- Terraform code
- architecture documentation
- phase notes
- learning summaries
- handoff documents

## Local Only

Keep the following outside the repository:

- AWS credentials
- `.env` files
- `terraform.tfvars`
- Terraform state files
- temporary build output
- screenshots or private notes that should not be public

## Separation Rules

- Public docs should explain engineering decisions, not private workflow
- Secrets should never appear in examples or screenshots
- Any public example should use placeholders
- Repository history should stay clean and reusable for future readers

## Secret Handling Model

- Use AWS SSO locally
- Use GitHub OIDC for automation
- Avoid long-lived access keys wherever possible
- Prefer least privilege and temporary credentials
