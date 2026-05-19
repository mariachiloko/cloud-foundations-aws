# Phase 3 Day 1 – Lambda & Serverless Foundations

## What I Did

- Started Phase 3 of the Cloud Foundations project
- Created the Phase 3 folder structure
- Added the Phase 3 README
- Added the initial Lambda architecture documentation
- Added Terraform placeholder files
- Focused on understanding Lambda concepts before deploying resources

## What I Learned

- AWS Lambda is a serverless compute service that runs code in response to events
- Serverless does not mean there are no servers; it means AWS manages the servers
- Lambda is event-driven, meaning it runs when something triggers it
- Lambda should use an IAM execution role instead of hardcoded credentials
- CloudWatch Logs are used to troubleshoot Lambda output and errors

## Key Concepts

### Serverless

Serverless means AWS manages the underlying servers, runtime environment, scaling, and availability. I still need to manage the code, permissions, triggers, and logs.

### AWS Lambda

Lambda runs code only when triggered. It is useful for automation, APIs, backend logic, file processing, scheduled tasks, and operational workflows.

### Event Trigger

An event trigger is what causes Lambda to run. Examples include API Gateway requests, S3 uploads, EventBridge schedules, DynamoDB stream events, and CloudWatch alarms.

### IAM Execution Role

Lambda uses an IAM execution role to get permission to access AWS services. This connects to the IAM work from Phase 2 because Lambda should use roles and least privilege instead of hardcoded credentials.

### CloudWatch Logs

CloudWatch Logs stores Lambda output and error messages. These logs are important for troubleshooting and understanding what happened during a function invocation.

## Basic Flow

```text
Event Trigger
     ↓
AWS Lambda Function
     ↓
CloudWatch Logs
```

## Why This Matters

Lambda is common in real AWS environments because it allows engineers to build systems that respond automatically to events without managing EC2 servers. It is used for automation, APIs, notifications, file processing, scheduled jobs, and operational tasks.

## Important Takeaway

Lambda is not just “code in the cloud.” It includes compute, IAM permissions, event triggers, logging, scaling, and troubleshooting. To use Lambda professionally, I need to understand the full execution flow, not just how to deploy a function.

## Interview Explanation

Simple version:

> AWS Lambda is a serverless compute service that runs code in response to events without requiring me to manage servers.

Deeper version:

> Lambda supports event-driven architecture. An event source triggers the function, AWS provides the runtime environment, the function runs with permissions from an IAM execution role, and logs are written to CloudWatch for troubleshooting. This allows cloud systems to scale automatically and respond to events without maintaining always-on servers.
