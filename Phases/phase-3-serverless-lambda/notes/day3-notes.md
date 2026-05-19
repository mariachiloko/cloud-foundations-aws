# Day 3 – Event Triggers with API Gateway

## What I Did

- Created an HTTP API using Amazon API Gateway
- Connected the API Gateway route to my existing AWS Lambda function
- Created a GET route using:
  
  ```text
  /hello
  ```

- Created a deployment stage named:

  ```text
  dev
  ```

- Tested the API endpoint from a browser
- Troubleshot a `message not found` error
- Successfully triggered the Lambda function through API Gateway
- Viewed Lambda invocation behavior and CloudWatch logging flow

---

# What I Learned

- Lambda functions are usually triggered by events, not manually executed all the time
- API Gateway acts as the public entry point for HTTP requests
- API Gateway routes requests to backend services like Lambda
- Event-driven architecture means systems react automatically when events occur
- API Gateway routes must match the request path exactly
- Stages are part of API deployment and affect endpoint URLs
- CloudWatch automatically stores Lambda logs after execution

---

# Key Concepts

## Event-Driven Architecture

Instead of running continuously like a traditional server, Lambda runs only when an event happens.

Examples of events:
- HTTP requests
- S3 uploads
- Scheduled events
- Database changes

---

## Amazon API Gateway

API Gateway is a managed AWS service that:
- receives HTTP requests
- manages routes
- forwards requests to Lambda
- returns responses back to users

It acts as the public-facing entry point for serverless applications.

---

## Lambda Trigger

The API Gateway route becomes the Lambda trigger.

Flow:

```text
User Request
     ↓
API Gateway
     ↓
Lambda Function
     ↓
CloudWatch Logs
```

---

## Deployment Stages

Stages allow APIs to have separate environments such as:
- dev
- test
- prod

The stage becomes part of the endpoint URL.

Example:

```text
https://api-id.execute-api.us-east-1.amazonaws.com/dev/hello
```

---

# What Was Confusing

- The API initially returned:

  ```text
  message not found
  ```

- It was confusing because the Lambda function itself was working correctly
- The issue was related to route matching and endpoint configuration rather than Lambda code

---

# Clarification

- API Gateway only invokes Lambda if:
  - the HTTP method matches
  - the route path matches
  - the stage is deployed correctly

- The endpoint URL structure matters:

  ```text
  Base URL + Stage + Route
  ```

- Once the correct route and stage path were used, the Lambda function executed successfully

---

# What Happened Behind the Scenes

1. Browser sent HTTP request
2. API Gateway received the request
3. API Gateway matched the route
4. API Gateway created an event object
5. Lambda executed the function
6. Lambda wrote logs to CloudWatch
7. API Gateway returned the response to the browser

AWS handled:
- scaling
- execution environment
- routing
- availability
- logging integration

without managing servers manually

---

# Why This Matters

This is one of the most common modern AWS architectures.

Real-world serverless systems often use:

```text
API Gateway → Lambda
```

This pattern is commonly used for:
- APIs
- automation
- lightweight applications
- backend services
- integrations between AWS services

---

# Design Principles

- Use API Gateway instead of exposing Lambda directly
- Use stages to separate environments
- Keep Lambda event-driven
- Use CloudWatch logs for troubleshooting
- Verify routes carefully before assuming Lambda is broken
- Understand the request flow before automating with Terraform

---

# Takeaway

I now understand how Lambda functions are triggered through API Gateway and how event-driven serverless architecture works in AWS. I also learned how API Gateway routes, stages, and integrations affect whether requests successfully reach Lambda.

# Additional Review Notes From Day 3 Assessment

## Important Corrections and Clarifications

### API Gateway Purpose

API Gateway is not only used to prevent direct access to Lambda.

It also:
- manages routes
- handles HTTP requests
- forwards requests to Lambda
- supports authentication
- supports throttling and rate limiting
- manages deployment stages

A stronger explanation is:

> API Gateway acts as the public-facing entry point that securely routes HTTP requests to backend services like Lambda.

---

## Lambda Execution Flow Clarification

Correct request flow:

```text
User Browser
     ↓
API Gateway
     ↓
API Gateway creates event
     ↓
Lambda Function executes
     ↓
Lambda uses IAM execution role if AWS permissions are needed
     ↓
Lambda writes logs to CloudWatch
     ↓
API Gateway returns response
     ↓
User receives response
```

Important clarification:
- Lambda does not assume the role before the request arrives
- The IAM execution role is used during function execution when AWS permissions are required

---

## Route Matching Behavior

This was an important troubleshooting lesson.

If the configured route is:

```text
GET /hello
```

and the request goes to:

```text
/dev/test
```

then:
- API Gateway returns a not found error
- Lambda is never triggered

This means:
- route paths must match correctly
- stage paths matter
- not all API errors are Lambda code problems

---

## Better Real-World Debugging Approach

A failed API request does not automatically mean:
- broken Lambda code

The issue could instead involve:
- incorrect route
- incorrect URL
- wrong deployment stage
- missing integration
- API Gateway configuration problems

Real-world cloud troubleshooting requires checking:
1. route configuration
2. deployment stage
3. integration mapping
4. logs
5. permissions
6. Lambda code

—not assuming the application code is always the issue first.

---

## Stronger Interview Talking Points

### Why Serverless Is Popular

Good reasons:
- reduced server management
- pay-per-use pricing
- automatic scaling
- faster deployments
- lower operational overhead

---

## Stronger Function vs Trigger Definition

- Lambda Function:
  - the code, runtime, and configuration

- Lambda Trigger:
  - the event source that invokes the function

Examples of triggers:
- API Gateway
- S3 uploads
- EventBridge schedules
- DynamoDB streams

---

# Takeaway From Assessment

The biggest improvement from today was learning to think through:
- request flow
- routing logic
- event flow
- troubleshooting paths

instead of assuming every issue is caused by application code.