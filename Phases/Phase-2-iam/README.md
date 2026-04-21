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

- IAM Users
- IAM Roles
- IAM Policies (JSON)
- Trust Relationships
- Least Privilege
- Temporary Credentials
- OIDC Authentication (GitHub → AWS)

---

## Architecture Focus

This phase introduces identity relationships instead of network flow:

- **Users** → represent human access (for learning purposes)
- **Roles** → used by services and applications
- **Policies** → define permissions
- **Trust Policies** → define *who can assume a role*

---

## Project Structure

```
phase-2-iam/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── versions.tf
│
├── docs/
│   ├── architecture.md
│   ├── iam-debugging.md
│   ├── oidc-debugging.md
│   └── oidc.md
│
└── README.md
```

---

## Build Method (MANDATORY)

Every concept follows this flow:

1. Manual Build (AWS Console)
2. Understand Behavior
3. Rebuild in Terraform
4. Compare Approaches

---

## What I Built

- IAM users (for learning purposes only)
- IAM roles with trust relationships
- Custom IAM policies (JSON)
- Permission testing (AccessDenied scenarios)
- GitHub OIDC authentication (no access keys)
- Terraform-based IAM configuration

---

## Security Best Practices Applied

- No hardcoded credentials
- Roles instead of long-term users
- Least privilege permissions
- OIDC instead of access keys for CI/CD
- Explicit permission documentation

---

## Common IAM Scenarios

### 1. Access Denied Errors
Cause:
- Missing permission in policy

Fix:
- Identify required action
- Update policy with least privilege

---

### 2. Role Cannot Be Assumed
Cause:
- Incorrect trust policy

Fix:
- Validate principal and conditions

---

### 3. OIDC Failure (GitHub Actions)
Cause:
- Mismatch in `sub` claim or audience

Fix:
- Align trust policy with GitHub repo format

---

## What I Learned

- IAM is about **identity + permissions**
- Roles are the standard approach in AWS
- Policies must be **intentional and minimal**
- Debugging IAM is a critical real-world skill
- OIDC removes the need for storing credentials

---

## Interview Talking Points

### Simple Explanation
"IAM controls who can do what in AWS. I used roles and policies to enforce least privilege and implemented OIDC to securely allow GitHub Actions to access AWS without storing credentials."

### Deeper Explanation
"I designed IAM using roles instead of users, defined permissions using JSON policies, and controlled access using trust relationships. I also implemented OIDC so GitHub could assume a role securely via STS, eliminating long-lived credentials."

---

## How This Connects to Other Phases

- Phase 1 (Networking): Controls traffic
- Phase 2 (IAM): Controls access
- Phase 3+: Builds on secure foundations

---

## Cleanup

Always remove unused IAM resources:
- Delete test users
- Remove unused roles
- Review policies

---

## Final Thought

This phase is about thinking like a security-minded engineer.

Not:
- "Does it work?"

But:
- "Is it secure?"
- "Is it minimal?"
- "Can I explain it?"

