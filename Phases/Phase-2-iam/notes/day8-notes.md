# Day 8 – IAM: Manual vs Terraform Comparison

## What I Did
- Compared IAM resources created manually in AWS vs Terraform
- Reviewed IAM roles, policies, and trust relationships in both environments
- Matched Terraform resources to actual AWS resources
- Reflected on when to use manual IAM vs Terraform
- Reviewed OIDC authentication flow between GitHub and AWS

---

## What I Learned

### Manual IAM vs Terraform IAM

- Manual IAM is useful for:
  - Learning
  - Debugging
  - Quick testing

- Terraform IAM is used for:
  - Consistency
  - Version control
  - Scaling environments
  - Reducing human error

- Manual changes can cause configuration drift
- Terraform enforces a desired state

---

### Configuration Drift

- Drift happens when:
  - A change is made manually in AWS
  - Terraform state no longer matches actual infrastructure

- Terraform detects this during:
  - terraform plan

- Terraform will attempt to:
  - Revert changes back to the defined configuration

---

### OIDC Authentication Flow (GitHub → AWS)

1. GitHub workflow starts
2. GitHub requests a temporary OIDC token
3. Token includes claims (repo, branch, etc.)
4. GitHub sends token to AWS
5. AWS checks token against IAM role trust policy
6. If valid → AWS allows role assumption
7. AWS returns temporary credentials
8. Terraform runs using those credentials

Key takeaway:
- No stored AWS credentials
- Access is temporary and verified

---

### Least Privilege (Applied)

- Only grant permissions required for the task
- Example:
  - Instead of full AWS access, limit Terraform role to only required actions

- Purpose:
  - Reduce risk
  - Limit blast radius

---

### Permission Policy vs Trust Policy

- Permission Policy:
  - Defines what actions are allowed

- Trust Policy:
  - Defines who can assume the role

Both are required:
- Wrong trust policy → role cannot be assumed
- Wrong permissions → role cannot perform actions

---

## Key Concepts

- IAM User = long-term identity (not preferred in modern setups)
- IAM Role = temporary identity (preferred)
- OIDC = secure authentication without access keys
- Least Privilege = minimum required permissions
- Drift = mismatch between Terraform and AWS
- State = Terraform’s record of infrastructure

---

## What I Was Working Through

- Understanding how OIDC actually works step-by-step
- Clarifying the difference between trust policy vs permission policy
- Understanding what happens when Terraform and AWS go out of sync (drift)

---

## Takeaways

- Roles are preferred over users because they use temporary credentials
- OIDC removes the need for storing sensitive AWS keys
- Terraform is required for real-world environments
- Manual IAM is still necessary for understanding and debugging
- Security mistakes in IAM can have major impact (data loss, unauthorized access)

---

## Interview Notes

### Why roles over users?
Roles use temporary credentials and reduce risk compared to long-lived access keys.

---

### What is OIDC?
OIDC allows external systems like GitHub to authenticate to AWS using temporary tokens instead of stored credentials.

---

### What is drift?
Drift occurs when infrastructure is changed manually and no longer matches Terraform configuration.

---

### What is least privilege?
Granting only the permissions required to perform a task, nothing more.