# Day 2 – Manual Lambda Build

## What I Did
- Created my first AWS Lambda function manually in the AWS Console
- Used the Python runtime to build a simple serverless function
- Allowed AWS to automatically create a basic Lambda execution role
- Modified the default Lambda code to return a custom JSON response
- Manually tested the function using a test event
- Viewed execution results directly in the Lambda console
- Opened CloudWatch Logs to inspect Lambda execution details
- Explored the Lambda execution role and attached permissions
- Reviewed Lambda configuration settings like memory and timeout

---

# What I Learned

## What Lambda Is
- AWS Lambda is a serverless compute service
- Serverless does NOT mean there are no servers
- It means AWS manages the infrastructure instead of me
- I only focus on the code and AWS handles execution and scaling

---

## Event-Driven Architecture
- Lambda runs because of events
- An event is something that triggers the function
- Examples:
  - API requests
  - File uploads to S3
  - Schedules
  - Manual test events
- Today I manually triggered the function myself

---

## Lambda Execution Flow
The Lambda execution flow works like this:

Event → Lambda Service → Execution Environment → Logs/Metrics → Response

When I clicked “Test”:
1. AWS received the event
2. AWS started the Lambda runtime environment
3. My Python code executed
4. Logs were sent to CloudWatch
5. A response was returned to me

---

# Lambda Code Understanding

## lambda_handler
- This is the main function AWS executes

## event
- Contains data passed into the function

## context
- Contains runtime information about the execution environment

## return statement
- Sends the response back after the function finishes

---

# CloudWatch Logs

## Why Logs Matter
- In serverless systems there is no server to log into directly
- Logs become one of the main ways to troubleshoot problems
- CloudWatch automatically collected Lambda logs

---

## Important Log Sections

### START
- Shows the beginning of the Lambda execution

### My print() statements
- Custom logs I added inside the function

### END
- Shows execution completion

### REPORT
Contains important metrics:
- Duration
- Billed Duration
- Memory Size
- Max Memory Used

---

# IAM Role Observations

## Lambda Execution Role
- Lambda uses an IAM role to get permissions
- The function itself does not have permanent credentials
- AWS temporarily allows the function to assume the role

---

## Why The Role Matters
Without the execution role:
- Lambda could not write logs to CloudWatch
- Lambda could not access other AWS services

This connects directly to the IAM concepts from Phase 2:
- roles
- least privilege
- temporary credentials

---

# Configuration Settings I Explored
I reviewed:
- Memory allocation
- Timeout settings
- Environment variables
- Permissions
- Monitoring section

I learned these settings affect:
- performance
- cost
- execution behavior
- scaling

---

# Key Concepts

## Serverless
AWS manages the infrastructure instead of me managing servers.

## Event-Driven
The application runs only when triggered by an event.

## Runtime
The language environment Lambda uses to execute code.

## Observability
Visibility into system behavior through logs and metrics.

## Execution Environment
The temporary runtime AWS creates to run Lambda code.

---

# What Surprised Me
- AWS automatically generated logs and metrics for the function
- Lambda execution was extremely fast
- The IAM role was already connected automatically
- CloudWatch logging was built directly into the Lambda workflow
- AWS handled all infrastructure behind the scenes

---

# Common Mistakes To Avoid

## Forgetting to Deploy
- Code changes do not apply until clicking “Deploy”

## Ignoring Logs
- Logs are critical for troubleshooting serverless systems

## Breaking Python Indentation
- Python relies heavily on spacing and indentation

## Forgetting IAM Permissions
- Many Lambda failures are actually permission problems

---

# Real-World Importance
Lambda is commonly used for:
- APIs
- automation
- monitoring
- file processing
- notifications
- event-driven applications

Understanding Lambda is important for:
- Cloud Engineering
- DevOps
- SysAdmin automation
- Serverless architecture

---

# Interview Notes

## Simple Explanation
“I created and tested a Lambda function manually in AWS to understand how serverless execution, IAM roles, and CloudWatch logging work together.”

---

## Deeper Explanation
“I explored the Lambda execution lifecycle, including event-driven execution, runtime behavior, CloudWatch observability, and IAM execution roles. I learned how AWS abstracts infrastructure management while still exposing operational visibility through logs and metrics.”

---

# Takeaway
I now understand the foundational behavior of AWS Lambda, including:
- how Lambda executes code
- how events trigger functions
- how IAM roles provide permissions
- how CloudWatch provides observability
- how AWS manages the underlying infrastructure in a serverless environment