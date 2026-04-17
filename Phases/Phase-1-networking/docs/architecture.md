# AWS VPC Architecture – Networking Design (Refined)

## Overview

This architecture represents a secure, multi-AZ AWS VPC designed using public and private subnets to support a layered application architecture.

The goal of this design is to:
- Control how traffic enters and leaves the environment
- Isolate sensitive resources from direct internet exposure
- Follow real-world cloud engineering patterns (least privilege, private-by-default)

---

## VPC Design

- **CIDR Block:** 10.0.0.0/20  
- Chosen to:
  - Avoid over-allocation (/16 would be excessive for this lab)
  - Allow multiple subnets across tiers and AZs
  - Leave room for future expansion without CIDR overlap

- Deployed across multiple Availability Zones for resilience

---

## Subnet Architecture (Multi-AZ)

### Availability Zone A
- Public Subnet A: 10.0.1.0/24  
- Private App Subnet A: 10.0.3.0/24  
- Private DB Subnet A: 10.0.5.0/24  

### Availability Zone B
- Public Subnet B: 10.0.2.0/24  
- Private App Subnet B: 10.0.4.0/24  
- Private DB Subnet B: 10.0.6.0/24  

### Design Purpose
- Public subnets → internet-facing entry points (ALB, NAT)
- Private app subnets → application logic (EC2)
- Private DB subnets → database isolation (RDS)
- Multi-AZ → improves fault tolerance and availability

---

## Public vs Private Subnets (Critical Concept)

Subnets are defined by **route tables**, not by name.

- **Public Subnet:** Has a route to Internet Gateway (IGW)
- **Private Subnet:** Does NOT have a direct route to IGW

This ensures:
- Only intended resources are publicly reachable
- Internal systems remain protected

---

## Core Components

### Internet Gateway (IGW)
- Attached to the VPC
- Enables internet connectivity for subnets that route to it
- Does NOT initiate traffic — it only allows it based on routing

---

### Application Load Balancer (ALB)
- Placed in public subnets
- Receives inbound internet traffic
- Forwards traffic to targets in private subnets
- Acts as the controlled entry point into the system

---

### NAT Gateway (Zonal Design)

- Deployed in **Public Subnet A**
- Allows private subnets to initiate outbound connections
- Prevents inbound internet access to private resources

#### Behavior:
- Private subnets route outbound traffic → NAT → IGW → Internet
- Return traffic is allowed because connections are stateful

#### Tradeoffs:
- Lower cost (single NAT)
- Cross-AZ traffic charges
- Single point of failure

#### Production Best Practice:
- One NAT per AZ
- Route private subnets to NAT in same AZ

---

### EC2 (Application Layer)
- Runs in private app subnets
- No direct internet exposure
- Only receives traffic from ALB via security groups

---

### RDS (Database Layer)
- Runs in private DB subnets
- No public access
- Only accessible from application layer

---

## Routing Design

### Public Route Table
- 0.0.0.0/0 → Internet Gateway
- Associated with public subnets

### Private Route Table
- 0.0.0.0/0 → NAT Gateway
- Associated with private subnets

---

## Traffic Flow (Correct Mental Model)

### Inbound Traffic (Internet → Application)

1. User sends request from internet  
2. Route tables allow traffic into VPC via Internet Gateway  
3. Traffic reaches ALB in public subnet  
4. ALB forwards request to EC2 in private subnet  
5. EC2 processes request (may query RDS)  
6. Response returns through ALB → Internet  

---

### Outbound Traffic (Private → Internet)

1. EC2 in private subnet initiates request  
2. Route table sends traffic to NAT Gateway  
3. NAT forwards traffic to Internet via IGW  
4. Response returns through NAT to EC2  

---

## Security Design

### Public Security Group
- Allows inbound HTTP (port 80) from 0.0.0.0/0
- Represents controlled public access

### Private Security Group
- Allows inbound traffic ONLY from public security group
- Blocks direct internet access

### Key Principle
- Use **security group references**, not CIDR ranges
- Enforces least privilege and controlled communication

---

## Failure Considerations

### NAT Gateway Failure
- Private subnets lose outbound internet access
- No impact on inbound application traffic
- Affects updates and external API calls

---

### Availability Zone Failure
- ALB routes to healthy AZ
- Multi-AZ resources failover if configured
- Improves system resilience

---

## Key Design Decisions

- Used /20 CIDR for balance between scale and efficiency
- Used single NAT to understand cost vs availability tradeoff
- Used explicit routing instead of defaults for full control
- Segmented subnets by tier for security and clarity

---

## Summary

This architecture demonstrates:

- Proper network segmentation
- Controlled internet exposure
- Correct routing behavior
- NAT usage for private outbound access
- Real-world cloud design patterns

Most importantly, it shows the ability to:
- Design intentionally
- Verify behavior
- Explain traffic flow clearly
