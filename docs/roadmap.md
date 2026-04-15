# Cloud Foundations Roadmap (Refined)

This roadmap outlines the progression of this project from foundational networking concepts to production-ready cloud architecture.

---

## Phase 1 — Networking (Completed)

### Goal
Design, build, and validate a secure, multi-AZ VPC architecture from scratch.

### What Was Built
- Custom VPC (10.0.0.0/20)
- 6 subnets across 2 Availability Zones:
  - Public Subnets (ALB + NAT)
  - Private App Subnets (EC2)
  - Private DB Subnets (RDS)
- Internet Gateway for controlled public connectivity
- NAT Gateway for private outbound access
- Route tables defining traffic flow
- Security groups enforcing least-privilege access

### Key Concepts Learned
- CIDR block sizing and subnetting strategy
- Public vs private subnet behavior (route table driven)
- Traffic flow through IGW, ALB, NAT, and route tables
- Multi-AZ design for high availability
- Cost vs resiliency tradeoffs (single NAT vs per-AZ NAT)

### Validation Performed
- Verified inbound traffic flows through ALB only
- Confirmed private subnets are not publicly accessible
- Tested outbound connectivity via NAT Gateway
- Observed routing behavior using route tables

### Outcome
Ability to design, explain, implement, and validate a production-style AWS network architecture.

---

## Phase 2 — IAM & Security

### Goal
Build secure identity and access control using least privilege.

### What Will Be Built
- IAM users, groups, and roles
- Role-based access for AWS services
- Secure policy design (inline vs managed)
- Credential management best practices

---

## Phase 3 — Serverless (Lambda)

### Goal
Build an event-driven architecture using AWS Lambda.

### What Will Be Built
- Lambda functions with API Gateway integration
- IAM roles for secure execution
- Logging and monitoring setup

---

## Phase 4 — Containers (ECS Fargate)

### Goal
Deploy containerized applications without managing servers.

### What Will Be Built
- ECS cluster and Fargate services
- Task definitions and networking integration
- Load balancing with ALB

---

## Phase 5 — CI/CD (GitHub Actions)

### Goal
Automate infrastructure and application deployment.

### What Will Be Built
- GitHub Actions workflows
- Terraform automation pipelines
- Secure secrets handling

---

## Phase 6 — Monitoring & Operations

### Goal
Implement visibility and operational awareness.

### What Will Be Built
- CloudWatch dashboards and logs
- Alerts and notifications
- Basic incident response workflows

---

## Phase 7 — Kubernetes (EKS)

### Goal
Understand container orchestration at scale.

### What Will Be Built
- EKS cluster with node groups
- Application deployment and scaling
- Networking and service exposure

---

## Phase 8 — Capstone Project

### Goal
Build a complete production-style system.

### What Will Be Built
- Full AWS architecture using Terraform
- CI/CD pipeline integration
- Monitoring and alerting system
- Secure and scalable infrastructure

---

## Engineering Philosophy

This project follows a deliberate approach:

1. Build to understand behavior  
2. Validate how the system actually works  
3. Rebuild using Infrastructure as Code (Terraform)  
4. Document decisions and tradeoffs  

---

## What This Project Demonstrates

- Ability to design cloud infrastructure intentionally  
- Understanding of real-world networking and security patterns  
- Experience validating system behavior, not just deploying resources  
- Readiness for sysadmin and cloud engineering responsibilities  
