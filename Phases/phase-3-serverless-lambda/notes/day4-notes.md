# Day 4 – Lambda IAM Roles & Permissions

## What I Did

- Reviewed the IAM execution role attached to my Lambda function
- Inspected the permissions policy attached to the role
- Reviewed the trust relationship for Lambda
- Confirmed Lambda had permission to write logs to CloudWatch
- Updated my architecture diagram to better represent the IAM relationship
- Learned the difference between Lambda triggers and Lambda permissions

---

# What I Learned

## Lambda Does Not Automatically Have AWS Permissions

A Lambda function cannot access AWS resources unless it is allowed through an IAM role.

AWS Lambda assumes an execution role at runtime.

That role defines what the function is allowed to do.

---

## Execution Role vs Trigger

I learned that these are two completely different things:

### Trigger

The trigger determines what can start the Lambda function.

Example:
- API Gateway
- S3 event
- EventBridge event

### Execution Role

The execution role determines what the Lambda function is allowed to access after it starts running.

Example:
- Write logs to CloudWatch
- Access S3
- Read DynamoDB
- Publish to SNS

---

# Key Concepts

## IAM Execution Role

An IAM role assumed by Lambda while the function runs.

The role provides temporary AWS credentials during execution.

---

## Trust Relationship

The trust relationship defines who is allowed to assume the role.

For Lambda, the trusted service is:

```json
{
  "Service": "lambda.amazonaws.com"
}
```

This means AWS Lambda is allowed to assume the role.

---

## Permissions Policy

The permissions policy defines what actions the Lambda function is allowed to perform.

For this stage, the Lambda function only needed permission to:

- Create log groups
- Create log streams
- Put log events into CloudWatch Logs

---

## Least Privilege

Least privilege means only granting the minimum permissions required.

Bad practice:
- AdministratorAccess
- Full access policies without reason

Good practice:
- Only allowing exactly what the workload needs

---

# Architecture Understanding

## Request Flow

```text
User → API Gateway → Lambda
```

This is application traffic flow.

---

## Permission Flow

```text
Lambda → assumes IAM role → allowed AWS actions
```

This is authorization flow, not network traffic.

---

# Diagram Improvement

I updated my architecture diagram to use a dotted arrow between Lambda and the IAM role:

```mermaid
L -.assumes at runtime.-> R[IAM Execution Role]
```

This better represents a trust/permission relationship instead of normal traffic flow.

---

# What AWS Is Doing Behind the Scenes

When API Gateway triggers the Lambda function:

1. AWS Lambda service receives the request
2. Lambda assumes the execution role
3. Temporary credentials are provided
4. The function runs using the permissions from the role
5. Lambda writes logs to CloudWatch if permitted

---

# Common Mistakes

## Confusing Trigger Permissions with Execution Permissions

A trigger only starts the function.

The execution role controls what the function can actually access.

---

## Giving Lambda Too Much Access

Using AdministratorAccess is dangerous because:

- It increases blast radius
- It weakens security
- It makes troubleshooting harder
- It violates least privilege principles

---

## Forgetting CloudWatch Permissions

Without logging permissions:
- Lambda may still run
- But logs will fail to appear

This makes troubleshooting difficult.

---

# Interview Notes

## Simple Explanation

A Lambda execution role is an IAM role that Lambda assumes while running. It defines what AWS services the function is allowed to access.

---

## Deeper Explanation

Lambda uses temporary credentials from an IAM execution role at runtime. The trust relationship allows the Lambda service to assume the role, while the attached permissions policies define the AWS actions the function can perform. This supports least-privilege security design.

---

# Takeaway

I now understand that Lambda triggers and Lambda permissions are separate concepts.

API Gateway controls whether Lambda gets triggered.

The IAM execution role controls what Lambda is allowed to do after it starts running.