# Cloud Foundations - Phase 4: Containers with ECS Fargate

## Purpose

This phase introduces container orchestration with Amazon ECS and AWS Fargate. The goal is not just to run containers, but to understand how containerized applications are deployed, networked, scaled, and observed in AWS without managing the underlying servers.

This phase builds on the earlier networking, IAM, and serverless work:

- Phase 1 established traffic flow and subnet design
- Phase 2 established least privilege, roles, and secure access
- Phase 3 established event-driven compute and operational cleanup
- Phase 4 now applies those foundations to containers

## What I Am Building

In this phase, I will first learn the ECS/Fargate architecture manually, then rebuild the same pattern with Terraform.

Planned learning flow:

1. Manual ECS and Fargate concept exploration
2. Architecture and traffic-flow reinforcement
3. Terraform implementation
4. Comparison and reflection

## Why This Matters

ECS Fargate is a common production pattern for teams that want container scheduling and scaling without managing EC2 worker nodes directly. Understanding it helps explain how container services connect to load balancers, roles, logs, and networking.

## Key Concepts

- **Container**: A packaged application with its runtime and dependencies
- **ECS Cluster**: The logical group that runs containerized workloads
- **Task Definition**: The blueprint for a containerized workload
- **Task**: A running instance of a task definition
- **Service**: Maintains the desired number of tasks and replaces failed ones
- **Fargate**: AWS-managed compute for running containers without managing servers

## Day 1 Goal

The goal for Day 1 is concept understanding and project structure only. No AWS resources are deployed yet.

By the end of Day 1, I should be able to explain:

- What ECS is
- What Fargate is
- Why containers fit this phase
- How task definitions and services relate
- How ECS integrates with networking and load balancing

## Project Structure

```text
phase-4-ecs/
├── README.md
├── docs/
│   └── architecture.md
├── terraform/
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   ├── versions.tf
│   └── terraform.tfvars.example
└── notes/
    └── day1-notes.md
```

## Security Notes

- Use IAM roles for ECS tasks and services
- Do not commit real Terraform variables or credentials
- Keep container images and deployment settings documented
- Avoid broad permissions unless they are justified

## Current Status

- Phase 4 structure created
- Day 1 concept exploration and project structure are next

