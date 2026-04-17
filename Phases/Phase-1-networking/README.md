# Cloud Foundations – AWS Networking (Phase 1)

## 📌 Project Overview

This project demonstrates the design, deployment, and validation of a production-style AWS VPC architecture.

The goal was not just to build infrastructure, but to understand:
- How traffic actually flows
- How AWS networking components interact
- How to design secure, layered systems

The environment was built using a **manual-first approach**, then replicated using **Terraform** to reinforce understanding and enable repeatability.

---

## 🏗️ Architecture Summary

- **VPC CIDR:** 10.0.0.0/20  
- **Availability Zones:** 2 (AZ A & AZ B)

### Subnets

| Tier | AZ A | AZ B |
|------|------|------|
| Public | 10.0.1.0/24 | 10.0.2.0/24 |
| Private App | 10.0.3.0/24 | 10.0.4.0/24 |
| Private DB | 10.0.5.0/24 | 10.0.6.0/24 |

### Core Components

- Internet Gateway (IGW)
- Application Load Balancer (ALB) in public subnets
- EC2 instances in private app subnets
- RDS (Multi-AZ) in private DB subnets
- NAT Gateway (single, for lab cost efficiency)

---

## 🎯 Objectives

- Design a secure, multi-AZ VPC architecture
- Implement public and private subnet patterns
- Control traffic flow using route tables and gateways
- Apply least-privilege networking principles
- Validate real-world traffic behavior
- Rebuild infrastructure using Terraform

---

## 🧠 Engineering Approach

This project follows a structured engineering workflow:

1. Manual build in AWS Console  
2. Concept validation and traffic flow analysis  
3. Terraform implementation  
4. Documentation of design decisions and tradeoffs  

---

## 🔁 Traffic Flow (Inbound)

1. User sends request from internet  
2. Traffic enters VPC via Internet Gateway  
3. Routed to Application Load Balancer in public subnet  
4. ALB forwards request to EC2 in private subnet  
5. EC2 processes request and may query RDS  
6. Response returns through ALB to user  

---

## 🌐 Traffic Flow (Outbound)

1. EC2 in private subnet initiates request  
2. Route table directs traffic to NAT Gateway  
3. NAT Gateway sends traffic through IGW to internet  
4. Response returns via NAT to EC2  

---

## 🔐 Security Design

- Only ALB is publicly accessible
- EC2 instances are private (no public IPs)
- RDS is fully isolated in private DB subnets
- Security groups enforce:
  - ALB → EC2 communication
  - EC2 → RDS communication

### Key Principle
Security groups reference other security groups instead of CIDR blocks to enforce **least privilege access**

---

## ⚠️ Failure Considerations

### NAT Gateway Failure
- Private subnets lose outbound internet access
- Application remains accessible via ALB

### Availability Zone Failure
- ALB routes traffic to healthy AZ
- Multi-AZ resources fail over (if configured)

---

## 🧪 Validation Performed

- Verified inbound traffic flows only through ALB
- Confirmed private subnets are not publicly accessible
- Tested outbound connectivity via NAT Gateway
- Validated route table associations and behavior

---

## 🚀 Outcome

This project demonstrates the ability to:

- Design cloud networking architecture intentionally  
- Implement secure, multi-tier environments  
- Validate system behavior beyond deployment  
- Understand real-world AWS networking patterns  

---

## 📊 Architecture Diagram

![Architecture Diagram](./architecture-diagram.png)

---

## 📎 Notes

- Single NAT Gateway used for cost efficiency in lab
- Production environments should use one NAT per AZ for high availability
