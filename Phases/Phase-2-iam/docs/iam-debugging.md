# IAM Debugging Guide (AccessDenied Troubleshooting)

## Purpose
This document explains how to troubleshoot IAM permission issues in AWS using real examples. The goal is to understand how AWS evaluates permissions and how to fix AccessDenied errors using least privilege principles.

---

## Common Error Example

```text
AccessDenied: User is not authorized to perform: s3:ListAllMyBuckets
```

---

## What This Means

This error indicates:
- The identity (user or role) attempted an action
- The action is valid in AWS
- But there is **no policy allowing it**

IAM does NOT partially allow actions.

If permission is missing → the request is denied.

---

## How AWS Evaluates Permissions

AWS follows this exact logic:

1. **Explicit Deny**
   - If any policy denies the action → request is denied immediately

2. **Allow**
   - If a policy explicitly allows the action → request is allowed

3. **Default Deny**
   - If no allow exists → request is denied

---

## Step-by-Step Debugging Process

### Step 1 – Identify the Identity
- Who is making the request?
  - IAM User
  - IAM Role
  - Service (Lambda, EC2, etc.)

---

### Step 2 – Identify the Action
- Look at the error message:
  - Example: `s3:ListAllMyBuckets`

---

### Step 3 – Check Attached Policies
- Go to IAM → User/Role → Permissions
- Review:
  - Inline policies
  - Attached policies

---

### Step 4 – Check for Missing Permissions
Ask:
- Is the required action explicitly allowed?

If not → this is the issue

---

### Step 5 – Check for Explicit Deny
- Look for:
  - `"Effect": "Deny"`

Even if an allow exists:
👉 Deny will override it

---

### Step 6 – Apply Least Privilege Fix

Instead of using:
```json
"Action": "*"
```

Use:
```json
{
  "Effect": "Allow",
  "Action": "s3:ListAllMyBuckets",
  "Resource": "*"
}
```

---

### Step 7 – Retest

After applying the fix:
- Retry the same action
- Confirm behavior changed

---

## Real Example (From This Project)

### Scenario
- Attached `AmazonS3ReadOnlyAccess`
- Could see buckets
- Could NOT upload files

### Why
- Policy allowed:
  - `ListBucket`
  - `GetObject`

- But NOT:
  - `PutObject`

### Fix
Added:
```json
{
  "Effect": "Allow",
  "Action": "s3:PutObject",
  "Resource": "*"
}
```

---

## Key Lessons Learned

- IAM is strict and rule-based
- Permissions must match the exact action
- AccessDenied errors are useful, not random
- Over-permissioning (AdministratorAccess) is not a real solution
- Least privilege improves both security and clarity

---

## Common Mistakes

### 1. Guessing Permissions
Trying random policies instead of reading the error

---

### 2. Overusing Admin Access
Fixing everything with:
```json
"Action": "*"
```
This hides the real issue and creates risk

---

### 3. Ignoring the Error Message
The error tells you exactly what is missing

---

### 4. Forgetting the Identity
Fixing the wrong user or role

---

## How to Explain This in an Interview

**Simple:**
“I debug IAM issues by analyzing AccessDenied errors and identifying missing permissions.”

**Stronger:**
“I follow AWS policy evaluation logic to troubleshoot IAM issues. I identify the identity, action, and missing permissions, then apply least privilege fixes instead of over-permissioning.”

---

## Final Takeaway

Understanding IAM is not about creating users and roles.

It is about:
- Knowing how permissions are evaluated
- Debugging failures
- Applying secure, minimal fixes

This is a core skill for real-world cloud engineering.