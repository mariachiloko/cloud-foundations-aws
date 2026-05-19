# Day 6 – Live Apply, Verification, and Cleanup

## What I Did

- Refreshed the AWS SSO session for the `cloud-foundations-sso` profile
- Ran a live Terraform plan against the Phase 3 stack
- Applied the stack in the AWS account
- Confirmed the outputs for the API endpoint, route URL, Lambda role, and log group
- Destroyed the stack immediately after verification to avoid ongoing charges

## What I Learned

- Terraform validation is not the same as a live AWS deployment
- AWS credentials and profile selection matter as much as the Terraform code
- A clean apply and a clean destroy are both part of responsible cloud engineering
- Even short-lived serverless resources should be cleaned up deliberately when the goal is learning

## What AWS Was Doing Behind the Scenes

When I applied the stack:

1. AWS created the Lambda execution role
2. AWS created the CloudWatch log group
3. AWS uploaded the Lambda package and configured the function
4. AWS created the HTTP API, integration, route, and stage
5. AWS attached the permission that lets API Gateway invoke Lambda

When I destroyed the stack:

1. API Gateway resources were removed first
2. Lambda permission and function were removed
3. IAM policy and role were removed
4. The CloudWatch log group was removed

## Operational Lesson

- Apply only what you need
- Verify it once
- Tear it down when you are done

That pattern keeps the project safe, cheap, and easy to reason about.

## Interview Explanation

I validated the serverless stack live in AWS using the intended SSO profile, confirmed the expected outputs, and then destroyed the entire stack immediately afterward so there would be no lingering cost or unmanaged resources.

## Manual vs Terraform Reflection

### Manual Build

Manual work helped me understand:

- how API Gateway routes a request to Lambda
- why the execution role and logs matter
- what breaks when the route or stage is wrong

### Terraform Build

Terraform helped me:

- express the same architecture in code
- review the full stack as a single change
- recreate the environment consistently
- destroy the environment cleanly after testing

### What the Live Apply Proved

- the Terraform configuration was not just syntactically valid
- the AWS account and profile setup were correct
- the stack could be created and torn down cleanly
- the deployment path matched the architecture documentation

### Final Interview Summary

“I built the Lambda and API Gateway flow manually first to understand the service behavior, then converted it to Terraform with a least-privilege execution role, CloudWatch logging, and a public HTTP API route. I validated it live in AWS, confirmed the outputs, and destroyed it immediately afterward so the lab stayed clean and cost-controlled.”
