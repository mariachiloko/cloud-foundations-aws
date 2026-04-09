# Cloud Foundations Roadmap

This roadmap outlines the progression of this project from foundational networking concepts to production-ready cloud architecture.

---

## Phase 1 — Networking (Current Phase)

### Goal
Build and understand a secure, multi-AZ VPC architecture from scratch.

### What Was Built
- Custom VPC (10.0.0.0/20)
- 6 subnets across 2 Availability Zones:
  - Public Subnets (ALB + NAT)
  - Private App Subnets (EC2)
  - Private DB Subnets (RDS)
- Internet Gateway for inbound/outbound public traffic
- NAT Gateway for outbound private subnet access
- Route tables controlling traffic flow
- Security groups enforcing least-privilege access

### Key Concepts Learned
- CIDR block sizing and subnetting strategy
- Public vs private subnet behavior
- Traffic flow through IGW, ALB, NAT, and route tables
- Multi-AZ design for high availability
- Cost vs resiliency tradeoffs (single NAT vs per-AZ NAT)

### Outcome
Ability to design, explain, and implement a production-style AWS network architecture.

---

## Phase 2 — IAM & Security

### Goal
Implement identity and access control using least privilege.

### Focus Areas
- IAM users, groups, and roles
- Policy design (inline vs managed)
- Role-based access for services (EC2, Lambda, etc.)
- Secure credential management

---

## Phase 3 — Serverless (Lambda)

### Goal
Understand event-driven architecture using AWS Lambda.

### Focus Areas
- Lambda functions and triggers
- API Gateway integration
- IAM roles for Lambda
- Logging and monitoring

---

## Phase 4 — Containers (ECS Fargate)

### Goal
Deploy containerized applications without managing servers.

### Focus Areas
- ECS clusters and services
- Fargate task definitions
- Load balancing with ALB
- Networking integration with VPC

---

## Phase 5 — CI/CD (GitHub Actions)

### Goal
Automate infrastructure and application deployment.

### Focus Areas
- GitHub Actions workflows
- Terraform automation
- Secure secrets handling
- Deployment pipelines

---

## Phase 6 — Monitoring & Operations

### Goal
Gain visibility into system performance and health.

### Focus Areas
- CloudWatch metrics and logs
- Alarms and notifications
- Troubleshooting and incident response

---

## Phase 7 — Kubernetes (EKS)

### Goal
Understand container orchestration at scale.

### Focus Areas
- EKS cluster setup
- Node groups and networking
- Deploying applications on Kubernetes
- Scaling and resilience

---

## Phase 8 — Capstone Project

### Goal
Combine all skills into a production-style system.

### Focus Areas
- Full architecture design
- Infrastructure as Code (Terraform)
- CI/CD pipeline
- Monitoring and alerting
- Security best practices

---

## Engineering Philosophy

This project follows a deliberate approach:

1. Build manually to understand behavior
2. Reinforce concepts and architecture decisions
3. Rebuild using Terraform
4. Document design decisions and tradeoffs

---

## Final Objective

Be able to:

- Design real-world AWS architectures
- Explain every component and decision clearly
- Build infrastructure using best practices
- Demonstrate job-ready cloud engineering skills
