# IAM Architecture – Phase 2 (Identity & Access Control)

## Overview

This phase introduces Identity and Access Management (IAM), which controls who can access AWS resources and what actions they are allowed to perform.

IAM works by separating:

- **Identity** — who or what is making the request
- **Authentication** — how AWS confirms the identity is valid
- **Authorization** — what that identity is allowed to do
- **Permissions** — the specific allowed or denied actions

This separation is critical for building secure and scalable cloud systems. IAM is not just about creating users or roles. It is about designing a clear access model where every identity has a purpose, every permission is intentional, and long-term credentials are avoided whenever possible.

---

## Architecture Evolution (Important)

This phase progressed through three stages:

1. **Manual IAM (Learning Phase)**
2. **OIDC Integration (CI/CD Security)**
3. **Terraform + AWS SSO (Production-Style Setup)**

The manual phase was used to understand IAM behavior directly in the AWS Console. The final design uses modern security practices: AWS SSO for human access, GitHub OIDC for automation, IAM roles for temporary access, and Terraform to manage the IAM resources consistently.

---

## Core Components

### IAM User (Learning Only)

- Represents an individual identity, such as a person or application
- Can authenticate using:
  - Username and password for AWS Console access
  - Access keys for programmatic access

⚠️ IAM users are not the preferred long-term design for this project.

They were used only to understand how IAM permissions work, how policies are attached, and how AWS responds when access is allowed or denied.

---

### IAM Role (Primary Design)

- Represents an assumable identity
- Used by:
  - AWS services
  - Applications
  - External systems, such as GitHub Actions through OIDC

IAM roles are preferred because they provide:

- Temporary credentials
- Better security
- Easier management
- No need to store long-term access keys

A role by itself does not automatically grant access. A role needs:

1. A **trust policy** that defines who can assume it
2. A **permission policy** that defines what it can do after it is assumed

---

### IAM Policy

An IAM policy is a JSON document that defines permissions.

A policy contains:

- **Effect** — Allow or Deny
- **Action** — the AWS API actions allowed or denied, such as `s3:GetObject`
- **Resource** — the AWS resource the action applies to
- **Condition** — optional rules that further restrict when the permission applies

Policies can be attached to users, groups, or roles. In this project, policies attached to roles are the preferred design.

---

### Trust Policy

A trust policy defines **who is allowed to assume a role**.

Examples:

- GitHub Actions can assume a role through OIDC
- An AWS service can assume a role to perform work
- A human identity can assume a role through AWS SSO or another identity provider

This is one of the most important IAM concepts in this phase:

- **Trust policy** = who can use the role
- **Permission policy** = what the role can do after it is used

---

## High-Level IAM Architecture

```text
Human Administrator
        |
        | aws sso login
        v
AWS IAM Identity Center (SSO)
        |
        | temporary credentials
        v
Terraform on Local Machine
        |
        | creates / updates IAM resources
        v
AWS Account


GitHub Actions Workflow
        |
        | requests OIDC token
        v
GitHub OIDC Provider
        |
        | token validated by AWS trust policy
        v
IAM Role for GitHub Actions
        |
        | temporary credentials from STS
        v
AWS Account Resources
```

---

## Authentication Architecture

### Local Development (Human Access)

**AWS SSO / IAM Identity Center** is used for human access.

Flow:

1. User runs `aws sso login`
2. Browser-based authentication opens
3. AWS confirms the user’s identity
4. AWS issues temporary credentials
5. Terraform uses those temporary credentials through the configured AWS profile

Benefits:

- No long-term access keys stored locally
- Temporary credentials reduce risk
- Centralized access control
- Better fit for real-world cloud environments

This is safer than creating an IAM user with access keys and storing those keys on a local machine.

---

### CI/CD Authentication (GitHub Actions)

**OIDC (OpenID Connect)** is used for GitHub Actions authentication.

Flow:

1. GitHub Actions workflow starts
2. The workflow requests an OIDC token from GitHub
3. AWS validates the token through the IAM OIDC provider
4. The IAM role trust policy checks token claims, including:
   - Repository claim (`sub`)
   - Audience claim (`aud`)
5. If the claims match, AWS STS allows the workflow to assume the IAM role
6. AWS issues temporary credentials
7. The workflow runs using only the permissions attached to that role

Benefits:

- No AWS access keys stored in GitHub secrets
- Short-lived credentials
- Access can be restricted to a specific repository or branch
- Better security for CI/CD pipelines

---

## IAM Access Flow Explanation

### 1. Identity Layer

The identity layer answers: **Who or what is making the request?**

In this phase, there are three identity patterns:

- IAM user for learning basic permission behavior
- AWS SSO identity for human administrator access
- GitHub Actions workflow using OIDC for automated access

The final architecture favors SSO and roles instead of long-term IAM users.

---

### 2. Trust Layer

The trust layer answers: **Who is allowed to assume this role?**

For GitHub Actions, the IAM role trust policy allows GitHub’s OIDC provider to request temporary access only when the token matches the expected conditions.

This prevents just any GitHub repository from assuming the role.

The trust policy protects the role from being used by the wrong identity.

---

### 3. Permission Layer

The permission layer answers: **What can the identity do after access is granted?**

Once a role is assumed, AWS checks the role’s permission policies.

The goal is least privilege:

- Grant only the actions required
- Limit permissions to specific resources where possible
- Avoid broad permissions unless there is a clear temporary learning reason

This means authentication alone is not enough. Even after GitHub assumes the role, it can only perform the actions allowed by the attached policies.

---

### 4. Execution Flow

When GitHub Actions runs a workflow:

1. GitHub authenticates the workflow run
2. GitHub provides an OIDC token
3. AWS receives the token
4. AWS checks the IAM OIDC provider configuration
5. AWS checks the IAM role trust policy
6. If the token claims match, AWS STS issues temporary credentials
7. The workflow uses those credentials to interact with AWS
8. AWS evaluates the permission policy attached to the role for every request

This creates a secure CI/CD authentication flow without storing AWS access keys in GitHub.

---

## Permissions Evaluation Flow

When a request is made to AWS:

1. The identity is authenticated
2. AWS gathers applicable policies
3. AWS checks for explicit deny statements
4. AWS checks for allow statements
5. AWS makes a final decision

Rules:

- **Explicit Deny** always wins
- **Allow** only works if no explicit deny blocks it
- If there is no allow, the request is denied by default

Final decision:

- Allowed ✅
- Denied ❌

This is why IAM is secure by default. Nothing is allowed unless a policy grants it.

---

## Example (Learning Phase Behavior)

### IAM User

- `phase2-test-user`

### Policy

- `AmazonS3ReadOnlyAccess`

### Observed Behavior

Allowed:

- View S3 buckets
- Read objects

Denied:

- Launch EC2 instances
- Modify IAM resources
- Perform non-S3 actions

This showed that IAM policies control specific actions. The user could only perform the actions allowed by the attached policy.

---

## Terraform Architecture (Final State)

IAM is managed using Terraform:

```text
terraform/
├── main.tf        # provider config using SSO profile
├── iam.tf         # IAM resources
├── variables.tf   # inputs such as GitHub repo
├── outputs.tf     # useful output values
├── versions.tf    # Terraform and provider version constraints
```

Resources created or managed:

- IAM OIDC Provider
- IAM Role for GitHub Actions
- IAM Trust Policy
- IAM Permission Policy
- Role Policy Attachment

Terraform provides repeatability. Instead of manually recreating the IAM setup, the configuration can be reviewed, version-controlled, and reapplied consistently.

---

## Manual vs Terraform Comparison

### Manual Build

Manual IAM work helped explain:

- Where IAM settings live in the AWS Console
- How users, roles, and policies appear visually
- What an access denied error looks like
- How attached policies affect real behavior

Manual work is useful for learning, but it is not ideal for repeatable infrastructure.

---

### Terraform Build

Terraform improved the design because it makes IAM:

- Repeatable
- Reviewable
- Version-controlled
- Easier to document
- Easier to rebuild safely

Terraform also reduces the risk of forgetting a manual setting, but it requires careful review because IAM mistakes can create serious security problems.

---

## Key Design Principles

### Least Privilege

Only grant the permissions required for the task.

This limits damage if an identity is misused or compromised.

---

### Roles Over Users

Roles provide temporary credentials and avoid long-term access keys.

Users were only used in this phase to understand IAM basics.

---

### Temporary Credentials

Temporary credentials reduce risk because they expire automatically.

This is why SSO and OIDC are preferred over static access keys.

---

### Separation of Concerns

This design separates:

- Human access through AWS SSO
- Automation access through GitHub OIDC
- Permissions through IAM policies
- Trust through IAM trust policies

This makes the architecture easier to reason about and safer to maintain.

---

### Deny by Default

AWS denies requests unless permission is explicitly granted.

This is a core security behavior and should always be expected when troubleshooting IAM.

---

## Real-World Considerations

### Why Access Keys Are Avoided

Long-term access keys are risky because they can be:

- Accidentally committed to GitHub
- Stored insecurely on a local machine
- Reused too broadly
- Forgotten after they are no longer needed

A leaked key can give an attacker whatever permissions the key owner has.

---

### Preferred Modern Approach

For this project, the preferred model is:

- AWS SSO for human users
- OIDC for GitHub Actions
- IAM roles for temporary access
- Least-privilege policies for authorization
- Terraform for repeatable infrastructure

---

## Common IAM Mistakes to Avoid

- Confusing trust policies with permission policies
- Giving broad permissions before understanding the required actions
- Using IAM users and access keys when roles or SSO would be safer
- Storing credentials in GitHub, code, or local files
- Forgetting that explicit deny overrides allow
- Assuming Terraform success means the permissions are correct without testing
- Manually changing IAM resources after Terraform manages them, which can create drift

---

### Simple Explanation

This phase built an IAM security foundation. I learned how AWS separates identity from permissions, why roles are preferred over users, and how least privilege reduces risk. I also configured GitHub Actions to authenticate to AWS using OIDC instead of long-term access keys.

### Deeper Explanation

The final design separates human and automation access. Human access uses AWS SSO, which provides temporary credentials for local Terraform work. GitHub Actions uses OIDC to request temporary credentials from AWS STS. The IAM role trust policy controls whether GitHub is allowed to assume the role, and the attached permission policy controls what the workflow can do after assuming it. This avoids static credentials and follows a more secure CI/CD pattern.

---

## Summary

This phase moved from basic IAM concepts to a production-style security model.

Implemented and documented:

- Identity vs permission separation
- IAM users for learning purposes
- IAM roles as the preferred design
- Trust policies and permission policies
- Least privilege access control
- Secure CI/CD authentication with OIDC
- Secure human authentication with AWS SSO
- Terraform-managed IAM infrastructure

This IAM foundation will support the rest of the Cloud Foundations project because every future AWS service will need secure identity, access, and permissions.
