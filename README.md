# Cloud Foundations - AWS Networking (Phase 1)

## 📌 Project Overview

This project demonstrates the design and implementation of foundational AWS networking components, including VPC architecture, subnet design, routing, and secure traffic control.

The environment is built using a manual-first approach to fully understand system behavior, followed by Terraform to enable repeatable and scalable infrastructure.

This project uses a **custom-designed multi-AZ VPC architecture** to reflect real-world cloud engineering practices.

---

## 🏗️ Architecture Summary

- **VPC CIDR:** 10.0.0.0/20  
- **Availability Zones:** 2 (A & B)

### Subnets

| Tier | AZ A | AZ B |
|------|------|------|
| Public | 10.0.1.0/24 | 10.0.2.0/24 |
| Private App | 10.0.3.0/24 | 10.0.4.0/24 |
| Private DB | 10.0.5.0/24 | 10.0.6.0/24 |

### Core Components

- Internet Gateway (IGW)
- Application Load Balancer (ALB) spanning both public subnets
- EC2 instances in private app subnets
- RDS (Multi-AZ) in private DB subnets
- NAT Gateway (single, for lab cost efficiency)

---

## 🎯 Objectives

- Design a secure and scalable VPC architecture
- Implement public and private subnet patterns across multiple availability zones
- Control traffic flow using route tables, gateways, and security groups
- Apply least-privilege networking principles
- Rebuild infrastructure using Terraform for consistency and automation

---

## 🧠 Engineering Approach

This project follows a structured workflow:

1. Manual implementation in AWS Console to understand behavior
2. Concept validation and traffic flow analysis
3. Terraform implementation for reproducibility
4. Documentation of design decisions and tradeoffs

---

## 🔁 Traffic Flow

1. User → Internet  
2. Internet → Internet Gateway  
3. IGW → Application Load Balancer (public subnets)  
4. ALB → EC2 (private app subnets)  
5. EC2 → RDS (private DB subnets)  
6. Response flows back through ALB  

---

## 🌐 Outbound Access

- EC2 instances in private subnets access the internet via:
  - **NAT Gateway (Public Subnet A)**

**Design Decision:**  
A single NAT Gateway is used to reduce cost in this lab.  
In production, one NAT Gateway per AZ would be used for high availability.

---

## 🔐 Security Design

- Only ALB is publicly accessible
- EC2 instances are private (no public IPs)
- RDS is isolated in private DB subnets
- Security groups control all traffic between layers

---

## ⚠️ Failure Considerations

- **NAT Failure:** Outbound traffic impacted, application still accessible  
- **AZ Failure:** Traffic routed to healthy AZ, system remains available  

---

## 🚀 Outcome

This project demonstrates the ability to design, build, and explain AWS networking infrastructure using real-world best practices, including:

- Multi-AZ architecture design  
- Secure tier isolation  
- Cost vs resilience tradeoff decisions  
- Infrastructure as Code (Terraform)

---

## 📊 Architecture Diagram

![Architecture Diagram](./architecture-diagram.png)
