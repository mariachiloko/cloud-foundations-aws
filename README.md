# Cloud Foundations AWS Project

## Overview
This project is a multi-phase AWS infrastructure build designed to simulate a real-world cloud environment using Terraform.

Each phase focuses on a core cloud concept and builds toward a production-style architecture. The goal is to demonstrate hands-on experience with designing, deploying, and managing scalable and secure infrastructure in AWS.

---

## Objectives
- Build real-world AWS infrastructure using Terraform (Infrastructure as Code)
- Develop a strong foundation in cloud architecture and networking
- Apply best practices for security, scalability, and reliability
- Create a structured portfolio that demonstrates practical cloud engineering skills

---

## Technologies Used
- AWS (VPC, IAM, EC2, ALB, ECS, Lambda, etc.)
- Terraform (Infrastructure as Code)
- Git & GitHub (version control and project tracking)

---

## Authentication Strategy

This project follows modern AWS security best practices by avoiding long-term credentials.

- **Local Development:** AWS SSO (IAM Identity Center)
  - Engineers authenticate through a browser login
  - Temporary credentials are issued for Terraform usage
- **CI/CD (GitHub Actions):** OIDC (OpenID Connect)
  - GitHub assumes an IAM role using short-lived tokens
  - No AWS access keys are stored in the repository or secrets

This separation ensures secure, scalable, and production-aligned authentication patterns.

---

## Project Structure

```
cloud-foundations/
│
├── README.md
├── .gitignore
|
├── phase-1-networking/
├── phase-2-iam/
├── phase-3-lambda/
├── phase-4-ecs/
├── phase-5-cicd/
├── phase-6-monitoring/
├── phase-7-eks/
└── phase-8-capstone/
```

Each phase is structured as an independent Terraform root module with its own:
- Terraform configuration
- Architecture documentation
- Phase-specific README

---

## Phases Breakdown

### Phase 1 – Networking
- VPC, subnets (public/private), route tables
- Internet Gateway and NAT Gateway
- Foundational networking architecture for a 3-tier application

### Phase 2 – IAM
- IAM users, roles, and policies
- Least privilege access design
- Secure authentication using AWS SSO and OIDC
- Terraform-managed IAM infrastructure

### Phase 3 – Lambda
- Serverless compute with AWS Lambda
- Event-driven architecture fundamentals

### Phase 4 – ECS
- Containerized applications using ECS
- Service deployment and scaling

### Phase 5 – CI/CD
- Infrastructure and application deployment pipelines
- Automation using GitHub Actions with OIDC authentication

### Phase 6 – Monitoring
- Logging and monitoring with CloudWatch
- Alerts and observability best practices

### Phase 7 – EKS
- Kubernetes cluster deployment with EKS
- Container orchestration concepts

### Phase 8 – Capstone
- Full production-style architecture combining all components
- End-to-end infrastructure design

---

## Why This Project Matters
This project demonstrates the ability to:
- Design and deploy AWS infrastructure using Infrastructure as Code
- Implement secure and scalable cloud architectures
- Use modern authentication methods (SSO and OIDC) instead of static credentials
- Organize and document complex systems clearly
- Apply real-world engineering practices beyond basic tutorials

---
