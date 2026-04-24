# IAM Architecture – Phase 2 (Identity & Access Control)

## Overview

This phase introduces Identity and Access Management (IAM), which controls who can access AWS resources and what actions they are allowed to perform.

IAM works by separating:

- Identity (who you are)
- Permissions (what you can do)

This separation is critical for building secure and scalable cloud systems.

---

## Architecture Evolution (Important)

This phase progressed through three stages:

1. **Manual IAM (Learning Phase)**
2. **OIDC Integration (CI/CD Security)**
3. **Terraform + AWS SSO (Production-Style Setup)**

---

## Core Components

### IAM User (Learning Only)
- Represents an individual identity (person or application)
- Can authenticate using:
  - Username/password (console)
  - Access keys (programmatic)

⚠️ Not used in production systems  
Used only to understand IAM behavior

---

### IAM Role (Primary Design)
- Represents an assumable identity
- Used by:
  - AWS services
  - Applications
  - External systems (GitHub via OIDC)

Provides:
- Temporary credentials
- Better security
- Easier management

---

### IAM Policy
- JSON document defining permissions
- Contains:
  - Effect (Allow or Deny)
  - Actions (e.g., s3:GetObject)
  - Resources

Attached to roles (preferred) or users (learning phase)

---

### Trust Policy
- Defines **who can assume a role**
- Example:
  - GitHub (OIDC)
  - AWS services

---

## Authentication Architecture

### Local Development (Human Access)

**AWS SSO (IAM Identity Center)**

Flow:
1. User runs `aws sso login`
2. Browser-based authentication
3. AWS issues temporary credentials
4. Terraform uses those credentials

Benefits:
- No long-term access keys
- Temporary credentials
- Centralized access control

---

### CI/CD Authentication (GitHub Actions)

**OIDC (OpenID Connect)**

Flow:
1. GitHub Actions requests OIDC token
2. AWS validates token via OIDC provider
3. Trust policy checks:
   - Repository (`sub` claim)
   - Audience (`aud`)
4. AWS issues temporary credentials
5. Workflow executes with IAM role permissions

Benefits:
- No stored credentials
- Short-lived access
- Secure, modern authentication

---

## Permissions Evaluation Flow

When a request is made:

1. Identity is authenticated
2. AWS evaluates all policies
3. Rules applied:
   - Explicit Deny → always denied
   - Allow → allowed if no deny exists
4. Final decision:
   - Allowed ✅
   - Denied ❌

---

## Example (Learning Phase Behavior)

### IAM User
- phase2-test-user

### Policy
- AmazonS3ReadOnlyAccess

### Observed Behavior

Allowed:
- View S3 buckets
- Read objects

Denied:
- Launch EC2
- Modify IAM
- Any non-S3 action

---

## Terraform Architecture (Final State)

IAM is fully managed using Terraform:

```
terraform/
├── main.tf        # provider config (SSO profile)
├── iam.tf         # IAM resources
├── variables.tf   # inputs (e.g., GitHub repo)
├── outputs.tf
```

Resources created:
- OIDC Provider
- IAM Role (GitHub Actions)
- IAM Policy
- Role Policy Attachment

---

## Key Design Principles

### Least Privilege
- Only grant required permissions
- Avoid overly broad access

---

### Roles Over Users
- Roles provide temporary credentials
- Users are avoided in production

---

### Separation of Concerns
- Human access (SSO)
- System access (OIDC)
- Permissions (Policies)

---

### Deny by Default
- Everything is denied unless explicitly allowed

---

## Real-World Considerations

### Why Access Keys Are Avoided
- Long-lived credentials are risky
- Can be leaked or misused

### Preferred Modern Approach
- AWS SSO for human users
- OIDC for automation
- Temporary credentials everywhere

---

## Summary

This phase moves from basic IAM concepts to a production-style security model.

You implemented:

- Identity vs permission separation
- Role-based access control
- Secure CI/CD authentication (OIDC)
- Secure human authentication (SSO)
- Terraform-managed IAM infrastructure

This forms the foundation for all secure AWS systems going forward.
