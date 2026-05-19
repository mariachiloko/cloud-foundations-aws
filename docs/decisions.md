# Architecture Decisions

## Networking

- Chosen VPC CIDR: `10.0.0.0/20`
- Reasoning: large enough for the lab phases, small enough to avoid tutorial-style over-allocation, and easy to subdivide without overlap
- Tradeoff: smaller than a `/16`, but more realistic for a portfolio environment

## Identity

- Human access uses AWS SSO instead of long-lived IAM users and access keys
- Automation uses GitHub OIDC instead of stored AWS credentials
- Roles are preferred over users for workloads because they issue temporary credentials and reduce blast radius

## Phase 3 Serverless

- Lambda uses an IAM execution role with least-privilege CloudWatch Logs permissions
- API Gateway HTTP API is used instead of the heavier REST API because the goal is to learn the core request flow without unnecessary complexity
- Log retention is explicitly configured to avoid indefinite log growth

## IaC

- Terraform is used to recreate the manual Lambda workflow so the architecture is repeatable and reviewable
- The Lambda source code is packaged from local source instead of committing build artifacts
