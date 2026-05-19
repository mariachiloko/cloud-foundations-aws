# Cloud Foundations – Phase 3: Serverless with AWS Lambda

## Purpose

This phase is focused on learning AWS Lambda and serverless architecture. The goal is not just to deploy a function, but to understand how event-driven systems work, how AWS runs code without managing servers, how IAM roles secure Lambda, and how CloudWatch helps with debugging.

This phase builds on the earlier networking and IAM foundations. Phase 1 helped establish traffic flow and AWS architecture thinking. Phase 2 helped establish least privilege, roles, policies, and secure authentication. Phase 3 now applies those ideas to serverless compute.

## What I Am Building

In this phase, I built a simple AWS Lambda-based system in two layers:

1. Manual Lambda and API Gateway exploration in the AWS Console
2. Terraform reconstruction of the same serverless flow

The first version focused on understanding the Lambda execution flow:

```text
Event Trigger
     ↓
AWS Lambda Function
     ↓
CloudWatch Logs
```

That manual work was later rebuilt with Terraform so the architecture could be reproduced, reviewed, and explained as code.

## Why This Matters

Lambda is commonly used in real AWS environments for automation, APIs, backend processing, scheduled jobs, file processing, notifications, and cloud operations tasks. Understanding Lambda helps explain how modern cloud systems run without traditional always-on servers.

## Key Concepts

- **Serverless**: A cloud model where AWS manages the servers, scaling, and runtime environment. The engineer focuses on code, permissions, events, and monitoring.
- **AWS Lambda**: A serverless compute service that runs code in response to events.
- **Event Trigger**: Something that causes Lambda to run, such as an API request, S3 upload, schedule, or CloudWatch event.
- **Execution Role**: An IAM role that Lambda assumes so it can access AWS services securely.
- **CloudWatch Logs**: The logging service used to view Lambda output, errors, and troubleshooting details.

## Day 1 Goal

The goal for Day 1 is concept understanding and project structure only. No AWS resources are deployed yet.

By the end of Day 1, I should be able to explain:

- What Lambda is
- What serverless means
- What event-driven architecture means
- Why Lambda needs an IAM execution role
- How CloudWatch Logs help with troubleshooting

## Project Structure

```text
phase-3-serverless-lambda/
├── README.md
├── docs/
│   ├── architecture.md
│   └── diagrams/
├── terraform/
│   ├── main.tf
│   ├── lambda_src/
│   │   └── app.py
│   ├── variables.tf
│   ├── outputs.tf
│   ├── versions.tf
│   └── terraform.tfvars.example
└── notes/
    ├── day1-notes.md
    ├── day2-notes.md
    ├── day3-notes.md
    ├── day4-notes.md
    ├── day5-notes.md
    └── day6-notes.md
```

## Security Notes

- Do not commit real `terraform.tfvars` files.
- Do not hardcode AWS access keys.
- Lambda permissions should use IAM roles, not embedded credentials.
- Policies should follow least privilege.
- Logs should be useful, but should not expose secrets.

## Current Status

- Phase 3 folder structure created
- Day 1 to Day 4 learning notes completed
- Day 5 Terraform implementation added
- Lambda execution role, CloudWatch logs, and HTTP API route defined in Terraform
- Day 6 live AWS apply and teardown completed against the `cloud-foundations-sso` account
