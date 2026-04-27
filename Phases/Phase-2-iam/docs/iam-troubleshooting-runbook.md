# IAM Troubleshooting Runbook

## Purpose
This runbook explains how to investigate common IAM permission problems in AWS.

## Common Error Types
- AccessDenied
- Not authorized to perform action
- Cannot assume role
- OIDC trust policy mismatch
- Resource policy conflict

## Troubleshooting Checklist

### 1. Identify the principal
Who is making the request?

### 2. Identify the action
What AWS action is being attempted?

### 3. Identify the resource
What resource is being accessed?

### 4. Check for explicit deny
Explicit deny overrides allow.

### 5. Check for missing allow
If no policy allows the action, AWS denies it by default.

### 6. Check the resource ARN
Make sure the policy points to the correct resource.

### 7. Check trust policy
For roles, verify who is allowed to assume the role.

### 8. Check Terraform vs Console drift
Confirm the AWS Console matches Terraform code.

### 9. Use IAM Access Analyzer or Policy Simulator
Validate policies before assuming they are correct.

## Scenario 1: User Cannot Access S3
Likely causes:
- Missing s3:ListBucket
- Wrong bucket ARN
- Explicit deny
- Bucket policy conflict

Investigation:
1. Confirm the user or role.
2. Confirm the exact failed action.
3. Check attached policies.
4. Check bucket policy.
5. Test with least privilege correction.

## Scenario 2: GitHub Actions Cannot Assume AWS Role
Likely causes:
- Wrong repository name in trust policy
- Wrong branch condition
- Missing id-token: write in workflow
- Wrong OIDC provider ARN

Investigation:
1. Check GitHub workflow permissions.
2. Check AWS role trust policy.
3. Confirm the sub claim matches repo and branch.
4. Confirm audience is sts.amazonaws.com.

## Scenario 3: Terraform Plan Fails with AccessDenied
Likely causes:
- Current AWS identity lacks permissions
- Wrong AWS profile
- SSO session expired
- Role does not allow required action

Investigation:
1. Run aws sts get-caller-identity.
2. Confirm the active profile/account.
3. Refresh SSO login if needed.
4. Check required IAM actions.
5. Update permissions only as narrowly as possible.

## Secure Fix Rules
- Do not add AdministratorAccess just to make an error go away.
- Do not use wildcard actions unless clearly justified.
- Do not hardcode access keys.
- Fix the smallest permission needed.
- Document why the permission exists.