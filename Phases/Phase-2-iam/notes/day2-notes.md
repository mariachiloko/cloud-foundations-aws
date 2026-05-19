# Day 2 – IAM Users (Manual Build)

## What I Did
- Created an IAM user in AWS (phase2-test-user)
- Enabled AWS Management Console access
- Attached the AmazonS3ReadOnlyAccess policy
- Logged in as the new user using an incognito window
- Tested allowed and denied actions in AWS

## What I Learned
- IAM controls who can access AWS and what they can do
- Users represent identities (people or applications)
- Policies define permissions using JSON
- AWS evaluates permissions on every request
- Least privilege means giving only the permissions required

## Key Concepts

### IAM User
- Represents a person or application
- Has login credentials (username/password or access keys)
- Not considered best practice for long-term use

### IAM Policy
- A JSON document that defines permissions
- Specifies:
  - Actions (what can be done)
  - Resources (where it can be done)
  - Effect (Allow or Deny)

### Permissions
- The result of policies attached to a user
- Determines what actions are allowed or denied

### Least Privilege (CRITICAL)
- Only grant the minimum permissions needed
- Reduces risk and improves security

## What Was Confusing
- Why we are creating IAM users if they are not best practice
- How AWS decides whether something is allowed or denied

## Clarification
- IAM users are created for learning purposes to understand identity
- In real-world systems, roles are used instead of users
- AWS evaluates:
  1. Identity (who is making the request)
  2. Policies (what they are allowed to do)
  3. Final decision (allow or deny)

## Testing Results

### Allowed
- Viewing S3 buckets (read-only access)

### Denied
- Creating EC2 instances
- Modifying IAM resources
- Performing actions outside S3 read permissions

## Takeaway
I now understand how AWS separates identity (users) from permissions (policies) and how access is evaluated. I also understand why least privilege is critical and why IAM users are not used in production environments.
