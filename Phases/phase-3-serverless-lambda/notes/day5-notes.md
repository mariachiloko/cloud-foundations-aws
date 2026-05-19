# Day 5 – Terraform Reconstruction of the Lambda Stack

## What I Did

- Rebuilt the Phase 3 Lambda workflow using Terraform
- Added a least-privilege IAM execution role for Lambda
- Added a scoped CloudWatch Logs policy for the function
- Created a dedicated CloudWatch log group with retention control
- Packaged the Lambda handler from local source code
- Created an API Gateway HTTP API with a `GET /hello` route
- Added the Lambda permission needed for API Gateway to invoke the function

## What I Learned

- Manual builds are good for understanding service behavior
- Terraform makes the same architecture repeatable and reviewable
- Lambda needs a trust policy and a permission policy
- API Gateway requires an explicit route and Lambda invoke permission
- Log retention should be set intentionally instead of left forever by default

## What AWS Is Doing Behind the Scenes

When the stack is applied:

1. Terraform uploads the Lambda package
2. AWS creates the Lambda execution role
3. Lambda assumes that role at runtime
4. CloudWatch receives logs from the function
5. API Gateway routes `GET /hello` to Lambda
6. API Gateway returns the Lambda response to the caller

## Manual vs Terraform

### Manual

Good for:

- learning the service console
- verifying behavior quickly
- troubleshooting one resource at a time

### Terraform

Good for:

- keeping the architecture in Git
- rebuilding the environment consistently
- explaining the final design in interviews

## Common Mistakes To Avoid

- Giving Lambda broad IAM permissions just because the function is small
- Forgetting the Lambda permission that allows API Gateway to invoke it
- Leaving logs at infinite retention without a reason
- Mixing manual console edits with Terraform without documenting drift

## Interview Explanation

“I first built the Lambda and API Gateway flow manually to understand the service behavior, then rebuilt the same stack in Terraform with a least-privilege execution role, CloudWatch logging, and an HTTP API route. That let me compare the operational tradeoffs between console work and Infrastructure as Code.”
