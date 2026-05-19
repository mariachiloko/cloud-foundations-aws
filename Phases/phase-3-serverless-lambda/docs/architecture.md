# Phase 3 Architecture – Serverless with AWS Lambda

## What We Are Doing

Phase 3 introduces serverless architecture using AWS Lambda. The goal is to understand how code can run in AWS without managing EC2 instances or traditional servers.

As of Day 5, the architecture exists both as a manual learning flow and as a Terraform-managed stack. The HTTP API trigger uses Amazon API Gateway, which means the Lambda function can be invoked through a web request instead of only through console testing.

This is the first working event-driven serverless flow in Phase 3.

## Current Architecture

```text
User / Browser
      ↓
Amazon API Gateway HTTP API
      ↓
GET /hello route
      ↓
AWS Lambda Function
      ↓
CloudWatch Logs
```

## Component Definitions

### User / Browser

The user or browser sends an HTTP request to the API Gateway invoke URL. This simulates how a real application or client would call a backend service.

### Amazon API Gateway

Amazon API Gateway is the public entry point for the serverless application. It receives HTTP requests and routes them to the correct backend integration.

In this phase, API Gateway is being used to trigger Lambda through an HTTP API.

API Gateway is important because Lambda functions are not normally exposed directly to the public internet. API Gateway provides a managed front door that can handle routing, stages, integrations, throttling, authentication, and other API features.

### HTTP API

An HTTP API is a simpler and lower-cost API Gateway option for routing HTTP requests to backend services like Lambda.

For this project, HTTP API is a good fit because the goal is to learn the basic event-driven flow without adding unnecessary complexity.

### Route

A route tells API Gateway what request path and method should trigger the backend integration.

Current route:

```text
GET /hello
```

This means a GET request to the `/hello` path triggers the Lambda function.

If the request path does not match a configured route, API Gateway does not invoke Lambda. This can result in a message such as:

```text
message not found
```

### Stage

A stage represents a deployed version or environment of the API.

In this project, the stage used was:

```text
dev
```

This follows a common real-world pattern where environments are separated, such as:

- dev
- test
- prod

The final invoke URL must match the stage and route configuration.

### AWS Lambda

AWS Lambda is a serverless compute service. It runs code only when triggered. AWS manages the underlying servers, scaling, runtime environment, and availability of the service.

Lambda is not the same as EC2. With EC2, I manage the server. With Lambda, AWS manages the server environment and I manage the function code, permissions, triggers, and logs.

### IAM Execution Role

A Lambda function uses an IAM execution role. This role gives Lambda permission to do specific actions, such as writing logs to CloudWatch or reading from another AWS service.

This connects directly to Phase 2 IAM work. Lambda should not use hardcoded credentials. It should use a role with only the permissions required.

### CloudWatch Logs

CloudWatch Logs stores Lambda output and error messages. This is how I troubleshoot the function when something breaks.

After API Gateway successfully invokes Lambda, CloudWatch can show invocation logs, request IDs, errors, and function output.

## Serverless Request Flow

1. A user or browser sends an HTTP request to the API Gateway invoke URL.
2. API Gateway receives the request.
3. API Gateway checks the stage, method, and route.
4. If the request matches `GET /hello`, API Gateway sends the event to Lambda.
5. Lambda runs the function code using its configured runtime.
6. Lambda uses its IAM execution role when it needs AWS permissions.
7. The function writes logs to CloudWatch.
8. Lambda returns a response to API Gateway.
9. API Gateway returns the HTTP response to the user.

## Event-Driven Architecture

This architecture is event-driven because the Lambda function runs in response to an event.

In this case, the event is an HTTP request received by API Gateway.

Instead of running a server all the time, the function runs only when the request happens. AWS handles the infrastructure needed to receive the event, invoke the function, scale the execution environment, and return the response.

## Why This Architecture Matters

This design is common in real AWS environments because it reduces server management and allows systems to respond automatically to events. It is useful for automation, lightweight APIs, file processing, scheduled jobs, and operational tasks.

This API Gateway to Lambda pattern is especially common for:

- serverless APIs
- web application backends
- internal automation endpoints
- form submissions
- lightweight business workflows

## Troubleshooting Lesson Learned

During testing, the API endpoint returned:

```text
message not found
```

This helped confirm an important API Gateway concept: API Gateway only invokes Lambda when the incoming request matches a configured route and deployed stage.

The issue was related to testing the correct invoke URL, stage, and route combination.

Important things to verify when this happens:

- The route exists, such as `GET /hello`.
- The route is attached to the Lambda integration.
- The correct stage is being used.
- The invoke URL includes the correct path.
- The stage is deployed or auto-deploy is enabled.

## Design Principles

- Keep the Lambda function small and focused.
- Use API Gateway as the managed public entry point.
- Use least privilege permissions for Lambda.
- Do not hardcode credentials.
- Log enough information to troubleshoot.
- Do not log secrets.
- Understand the manual build before using Terraform.
- Treat Lambda as event-driven compute, not as a tiny EC2 server.

## Current Status

Completed so far in Phase 3:

- Basic Lambda concept review
- Manual Lambda function creation
- API Gateway HTTP API trigger
- `GET /hello` route
- Successful browser-based invocation
- Initial troubleshooting of route/stage behavior
- Live Terraform apply in AWS
- Immediate teardown after verification to avoid lingering resources and cost

## Future Architecture Expansion

Later in this phase, the architecture may expand to include additional event sources or infrastructure-as-code implementation.

Possible future patterns:

```text
S3 Object Upload
      ↓
AWS Lambda
      ↓
CloudWatch Logs
```

```text
EventBridge Schedule
      ↓
AWS Lambda
      ↓
CloudWatch Logs
```

```text
Terraform
      ↓
API Gateway + Lambda + IAM Role
      ↓
CloudWatch Logs
```

The next steps should continue following the project method:

1. Manual build
2. Concept reinforcement
3. Terraform implementation
4. Comparison and reflection

## Terraform Implementation

The Terraform stack now maps the manual build to explicit resources:

- `aws_iam_role.lambda_execution_role` creates the Lambda execution role
- `aws_iam_role_policy.lambda_logs` grants least-privilege CloudWatch Logs access
- `aws_cloudwatch_log_group.lambda` stores function logs with retention control
- `aws_lambda_function.hello` deploys the Python handler
- `aws_apigatewayv2_api.http_api` creates the HTTP API front door
- `aws_apigatewayv2_route.hello` maps `GET /hello` to the Lambda integration
- `aws_apigatewayv2_stage.dev` exposes the deployed `dev` stage
- `aws_lambda_permission.allow_apigateway` allows API Gateway to invoke the function

## Manual vs Terraform

### Manual Build

Manual work was useful for:

- observing the Lambda console directly
- understanding how API Gateway routes and stages affect requests
- verifying IAM trust and permission behavior by hand

### Terraform Rebuild

Terraform is better for:

- repeatability
- change review
- version control
- rebuilding the same pattern in future phases

### Operational Tradeoff

Manual setup is faster for learning one-off behavior.
Terraform is safer for long-lived portfolio work because it captures the architecture as code and makes the rebuild process transparent.

The live apply-and-destroy cycle shows a third operational pattern:

- validate the stack in AWS
- verify the important outputs
- destroy the environment when it is no longer needed

This matters in real environments because the engineer is responsible not only for creating resources, but also for removing them when the work is complete. Cleanup is part of the architecture, not an afterthought.
