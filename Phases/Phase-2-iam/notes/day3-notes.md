# 🔵 Day 3 – IAM Roles & When to Use Users vs Roles

## What I Did
- Learned what an IAM Role is in AWS
- Looked at how roles are used instead of long-term credentials
- Focused on the difference between:
  - **IAM Users**
  - **IAM Roles**
- Worked through **when to use each one**
- Learned that roles are generally preferred in modern AWS environments

---

## What I Learned
- **IAM Users** are long-term identities, usually for people
- **IAM Roles** provide temporary access
- Roles are generally more secure because they use temporary credentials
- In AWS, the best practice is usually:
  - **humans authenticate**
  - then **assume roles**
- AWS services like Lambda, EC2, and ECS should use **roles**, not stored access keys

---

## Key Concepts

### IAM User
- A long-term AWS identity
- Can have:
  - Console password
  - Access keys
- Typically used for:
  - Human access
  - Initial account setup
  - Rare legacy scenarios

---

### IAM Role
- A temporary AWS identity
- Assumed by a trusted user, service, or system
- Gets temporary credentials from AWS
- Typically used for:
  - AWS services
  - CI/CD pipelines
  - Cross-account access
  - Temporary elevated access

---

### Temporary Credentials
- Short-lived credentials issued when a role is assumed
- More secure than permanent access keys
- Reduce risk if credentials are exposed

---

## Real-World Understanding

### When IAM Users Make Sense
- A human needs to sign in to AWS
- Initial account/bootstrap access
- A legacy tool only supports access keys
- A local script or older workflow cannot use role assumption

### When IAM Roles Make Sense
- Lambda needs access to CloudWatch or S3
- EC2 needs to call AWS APIs
- GitHub Actions needs to deploy into AWS
- One AWS account needs access to another
- Someone needs temporary elevated permissions

---

## What I Was Actually Working Through
- **When should I use a user?**
- **When should I use a role?**
- If roles are better, **why do users still exist?**
- Understanding that users are often the identity that logs in, while roles are the safer way permissions are granted

---

## Clarification

### Best-Practice Mental Model
- **User = identity**
- **Role = temporary access**

### Modern AWS Pattern
- Human signs in
- Human assumes role
- Role grants the needed permissions

### Service Pattern
- AWS service assumes role
- Role grants only the permissions needed

---

## Straight Truth
- If a workload or AWS service needs access, **use a role**
- If a person needs to log in, a user may still exist, but it is better for that person to **assume a role**
- If you are relying heavily on IAM users with long-term credentials, that is usually a weaker design

---

## Common Mistakes (Critical)
- Using IAM users for workloads instead of roles
- Storing access keys in code or scripts
- Giving humans direct long-term permissions instead of role-based access
- Thinking users are obsolete
- Thinking roles completely replace users in every situation

---

## Interview Notes

### Simple Explanation
IAM users are long-term identities, usually for people. IAM roles provide temporary access and are preferred for AWS services, workloads, and most secure access patterns.

---

### Strong Explanation
In AWS, IAM users are mainly used to represent human identities or support limited legacy access needs, while IAM roles are the preferred way to grant permissions because they use temporary credentials. In a modern design, humans often authenticate first and then assume roles, while AWS services like Lambda and EC2 use roles directly instead of storing long-term credentials.

---

## Portfolio Notes

### What to Document
- Why roles are preferred over users
- Real examples of when users still make sense
- Real examples of when roles are the correct design choice
- Why temporary credentials are safer than long-term keys

---

## Comparison

| Type | Best Used For | Credential Type | Best Practice |
|------|---------------|----------------|---------------|
| IAM User | Human identity / limited legacy use | Long-term | Use carefully and often with role assumption |
| IAM Role | Services, workloads, CI/CD, cross-account access | Temporary | Preferred |

---

## Final Takeaway
IAM users still have a place, mainly for human identity and limited edge cases.

But in modern AWS design, **roles are usually the better choice** because they provide temporary, safer, and more flexible access.