# Cloud Foundations - Phase 2: IAM & Security Foundations

## Overview

This phase focuses on understanding how access is controlled and secured in AWS using Identity and Access Management (IAM).

The goal is not just to create users and roles, but to deeply understand:
- Who can access AWS resources
- What actions they are allowed to perform
- How to design secure, least-privilege systems

This phase follows a **manual → understand → Terraform → compare** workflow.

---

## Why This Phase Matters

In real-world cloud environments, **security failures are often IAM failures**.

If IAM is done incorrectly:
- Users may gain excessive access (security risk)
- Systems may fail due to missing permissions
- CI/CD pipelines may break
- Sensitive data may be exposed

Strong IAM skills are essential for:
- Cloud Engineers
- SysAdmins
- DevOps Engineers

---

## Key Concepts Covered

- IAM Users (learning only)
- IAM Roles
- IAM Policies (JSON)
- Trust Relationships
- Least Privilege
- Temporary Credentials
- AWS SSO (IAM Identity Center)
- OIDC Authentication (GitHub → AWS)
- Configuration Drift

---

## Architecture Focus

This phase introduces identity relationships instead of network flow:

- **Users** → represent human access (learning phase only)
- **Roles** → used by services and applications
- **Policies** → define permissions
- **Trust Policies** → define *who can assume a role*

Authentication design:

### Local (Human Access)
- AWS SSO (IAM Identity Center)
- Temporary credentials via browser login

### CI/CD (Automation)
- GitHub Actions uses OIDC
- AWS validates identity via trust policy
- AWS issues temporary credentials via STS
- No stored access keys

---

## Architecture

See architecture.md for detailed IAM design, including:
- Identity vs permission separation
- OIDC authentication flow
- Role assumption model

---

## Project Structure

phase-2-iam/
│
├── terraform/
├── docs/
│   ├── iam-comparison.md
│   ├── architecture.md
│   ├── iam-debugging.md
│   ├── oidc.md
│   ├── oidc-debugging.md
└── README.md

---

## Manual vs Terraform IAM

Manual IAM is useful for learning and debugging. Terraform IAM is used for consistency, version control, and scaling environments.

---

## Configuration Drift

Configuration drift occurs when infrastructure is changed manually and no longer matches Terraform configuration.

---

## Security Best Practices Applied

- No hardcoded credentials
- Roles instead of users
- Least privilege permissions
- AWS SSO for human authentication
- OIDC for CI/CD authentication

## IAM Permission Scope

The original Terraform deployment policy temporarily used `Action = "*"` and `Resource = "*"` during early testing.

That was replaced with a scoped IAM-focused policy that only allows IAM and OIDC actions required for this phase.

Some IAM actions still use `Resource = "*"` because certain IAM list/create operations do not support tight resource-level scoping in the same way as services like S3. This is documented as an intentional limitation and future improvement area.
---

## Final Thought

This phase is about thinking like a security-minded engineer.
