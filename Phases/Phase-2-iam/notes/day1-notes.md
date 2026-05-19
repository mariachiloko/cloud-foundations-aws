# Day 1 – IAM Concepts

## What I Did
- Studied AWS IAM fundamentals
- Learned how AWS controls access to resources
- Understood the difference between users, roles, and policies
- Learned how trust relationships work
- Reviewed the principle of least privilege

## What I Learned
- IAM (Identity and Access Management) controls who can do what in AWS
- Every AWS request is evaluated against IAM before it is allowed or denied
- IAM is made up of identities (users/roles) and permissions (policies)
- Roles are preferred over users because they use temporary credentials
- Trust relationships define who is allowed to assume a role
- Least privilege is critical for security and means giving only the permissions required

## Key Concepts

### IAM (Identity and Access Management)
Controls access to AWS resources by evaluating identities and permissions.

### Authentication vs Authorization
- Authentication = Who you are (logging in)
- Authorization = What you are allowed to do

### IAM User
A long-term identity with credentials (username/password or access keys), typically used for human access.

### IAM Role
A temporary identity with permissions that can be assumed by AWS services or users. Does not have long-term credentials.

### IAM Policy
A JSON document that defines what actions are allowed or denied on specific resources.

### Trust Relationship
Defines which entity (user, service, or external system) is allowed to assume a role.

### Least Privilege
Granting only the permissions required to perform a task and nothing more.

## What Was Confusing
- The difference between users and roles at first
- What a trust relationship actually controls
- How AWS decides whether to allow or deny a request

## Clarification
- Users are long-term identities, but roles are preferred for security
- Roles are used by AWS services (like EC2 or Lambda) and external systems
- Policies define permissions (what actions are allowed)
- Trust relationships define who can assume a role
- AWS evaluates every request by checking identity + policy + context

## Real-World Insight
- Most cloud security issues come from IAM misconfigurations, not networking
- Over-permissioned access (like AdministratorAccess) is a major risk
- Modern AWS environments rely heavily on roles and temporary credentials instead of users

## Takeaway
IAM is the foundation of AWS security. Understanding identities, permissions, and trust relationships is critical before building anything, because every AWS action depends on IAM evaluation.