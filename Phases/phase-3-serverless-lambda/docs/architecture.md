# Phase 3 Architecture – Serverless with AWS Lambda

## What We Are Doing

Phase 3 introduces serverless architecture using AWS Lambda. The goal is to understand how code can run in AWS without managing EC2 instances or traditional servers.

At this stage, the architecture is conceptual. No production workload is being deployed yet.

## Basic Architecture

```text
Event Trigger
     ↓
AWS Lambda Function
     ↓
CloudWatch Logs
```

## Component Definitions

### Event Trigger

An event trigger is what causes the Lambda function to run. Lambda does not normally sit there like a traditional server waiting forever. It runs when something happens.

Examples of possible event sources:

- API Gateway request
- S3 object upload
- EventBridge schedule
- DynamoDB stream event
- CloudWatch alarm

### AWS Lambda

AWS Lambda is a serverless compute service. It runs code only when triggered. AWS manages the underlying servers, scaling, runtime environment, and availability of the service.

Lambda is not the same as EC2. With EC2, I manage the server. With Lambda, AWS manages the server environment and I manage the function code, permissions, triggers, and logs.

### IAM Execution Role

A Lambda function uses an IAM execution role. This role gives Lambda permission to do specific actions, such as writing logs to CloudWatch or reading from another AWS service.

This connects directly to Phase 2 IAM work. Lambda should not use hardcoded credentials. It should use a role with only the permissions required.

### CloudWatch Logs

CloudWatch Logs stores Lambda output and error messages. This is how I will troubleshoot the function when something breaks.

## Serverless Flow

1. An event happens.
2. AWS invokes the Lambda function.
3. Lambda runs the code using its configured runtime.
4. Lambda uses its IAM execution role when it needs AWS permissions.
5. The function writes logs to CloudWatch.
6. The function completes and stops running.

## Why This Architecture Matters

This design is common in real AWS environments because it reduces server management and allows systems to respond automatically to events. It is useful for automation, lightweight APIs, file processing, scheduled jobs, and operational tasks.

## Design Principles

- Keep the function small and focused.
- Use least privilege permissions.
- Log enough information to troubleshoot.
- Do not log secrets.
- Understand the manual build before using Terraform.
- Treat Lambda as event-driven compute, not as a tiny EC2 server.

## Future Architecture Expansion

Later in this phase, the architecture may expand to include:

```text
API Gateway
     ↓
AWS Lambda
     ↓
CloudWatch Logs
```

Or:

```text
S3 Event
     ↓
AWS Lambda
     ↓
CloudWatch Logs
```

The final trigger will be chosen intentionally based on what best supports the portfolio project and learning goals.
