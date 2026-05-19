# Day 5 – IAM Permission Debugging (Break It)

## What I Did
- Tested IAM permissions by attaching limited policies to a user/role
- Attempted actions in AWS (S3) to intentionally trigger failures
- Observed AccessDenied errors when permissions were missing
- Removed all permissions to fully break access
- Created a custom policy with minimal permissions (list buckets only)
- Re-tested actions to understand partial access behavior

## What I Learned
- IAM follows a strict model: default deny unless explicitly allowed
- Even small missing permissions will completely block actions
- Permissions can be very granular (ex: list buckets vs access bucket contents)
- AccessDenied errors are expected and useful for debugging
- The error message usually tells you exactly what permission is missing

## Key Concepts
- Default Deny: Nothing is allowed unless explicitly permitted
- Allow vs Deny:
  - Explicit deny always wins
  - Allow only works if no deny exists
- Least Privilege: Only grant what is needed, nothing more
- Policy Evaluation:
  1. Check for explicit deny
  2. Check for allow
  3. Otherwise deny
- AccessDenied Error:
  - Happens when an action is not allowed by policy
  - Example: missing s3:ListBucket

## What I Worked Through
- Understanding why I could see S3 buckets but not interact with them
- Seeing how removing permissions completely blocks access
- Realizing that permissions must match the exact action being attempted
- Learning that fixing IAM is not guessing — it’s reading the error and adjusting policy

## Clarification
- IAM is not flexible — it is strict and rule-based
- If something fails, it is almost always due to missing permission
- Partial access is normal (you can allow one action and deny another)
- The safest way to fix issues is to add only the exact permission needed

## Takeaway
I now understand how IAM behaves in real scenarios. Instead of just creating users and roles, I can troubleshoot permission issues by reading AccessDenied errors and adjusting policies using least privilege. This is a core real-world cloud engineering skill.