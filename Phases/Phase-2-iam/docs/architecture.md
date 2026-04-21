# IAM Architecture – Phase 2 (Identity & Access Control)

## Overview

This phase introduces Identity and Access Management (IAM), which controls who can access AWS resources and what actions they are allowed to perform.

IAM works by separating:

- Identity (who you are)
- Permissions (what you can do)

This separation is critical for building secure and scalable cloud systems.

---

## Components

### IAM User
- Represents an individual identity (person or application)
- Can authenticate using:
  - Username and password (console access)
  - Access keys (programmatic access)

⚠️ IAM users are NOT best practice for production systems  
They are used here for learning purposes only.

---

### IAM Policy
- A JSON document that defines permissions
- Contains:
  - Effect (Allow or Deny)
  - Actions (e.g., s3:GetObject)
  - Resources (specific AWS resources)

Policies are attached to users, groups, or roles.

---

### Permissions Flow

When a user makes a request:

1. AWS authenticates the identity (login)
2. AWS evaluates all attached policies
3. AWS determines:
   - Explicit Deny → always denied
   - Allow → allowed if no deny exists
4. Request is either:
   - Allowed ✅
   - Denied ❌

---

## Example Setup (Day 2)

### IAM User
- Name: phase2-test-user

### Attached Policy
- AmazonS3ReadOnlyAccess

---

## Behavior Observed

### Allowed Actions
- View S3 buckets
- Read S3 objects

### Denied Actions
- Launch EC2 instances
- Modify IAM resources
- Perform actions outside S3 read scope

---

## Key Design Principles

### Least Privilege
- Only grant required permissions
- Avoid broad access like AdministratorAccess

---

### Separation of Identity and Permissions
- Users represent identity
- Policies define permissions
- This separation improves flexibility and security

---

### Deny by Default
- All actions are denied unless explicitly allowed

---

## Real-World Considerations

### Why IAM Users Are Not Used in Production
- Long-term credentials increase security risk
- Harder to manage at scale
- Do not support temporary access

### Preferred Approach
- Use IAM Roles instead
- Roles provide:
  - Temporary credentials
  - Better security
  - Easier management

---

## Summary

IAM is the security foundation of AWS.

Understanding how identity and permissions interact is critical for:
- Securing infrastructure
- Preventing unauthorized access
- Designing scalable systems

This phase establishes the foundation for using roles and advanced security patterns in later steps.
