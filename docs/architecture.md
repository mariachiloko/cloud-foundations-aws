# Cloud Foundations Architecture

## Project Shape

The project is organized as a progression of cloud building blocks:

1. Networking establishes traffic flow and subnet design
2. IAM establishes identity, trust, and least privilege
3. Lambda introduces serverless execution and event-driven design
4. Future phases add containers, CI/CD, monitoring, and orchestration

## Current Phase Focus

Phase 3 currently demonstrates a serverless request path:

```text
User / Browser
  -> API Gateway HTTP API
  -> GET /hello route
  -> Lambda function
  -> CloudWatch Logs
```

## Security Reasoning

- Lambda runs through an execution role instead of embedded credentials
- API Gateway is the public entry point instead of exposing Lambda directly
- Logs are retained intentionally instead of forever
- The build uses Terraform so the final design can be reviewed and reproduced

## Operational Notes

- Manual console work is useful for learning service behavior
- Terraform is better for repeatability and change tracking
- The same architecture should be explainable from both the console and the code
- Failure often appears as routing, permissions, or logging issues rather than application code issues
