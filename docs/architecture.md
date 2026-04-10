# AWS VPC Architecture – Networking Design

## Overview

This architecture defines a secure, multi-AZ VPC network designed using public and private subnets to support a 3-tier application (web, application, and database layers).

The design separates internet-facing components from internal services and controls traffic flow using route tables, an Internet Gateway (IGW), and a NAT Gateway.

---

## VPC Design

- **CIDR Block:** 10.0.0.0/20  
- Sized to balance efficient IP usage with room for growth
- Supports segmentation across multiple subnets and tiers
- Deployed across multiple Availability Zones for high availability

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
- Public subnets host internet-facing components
- Private app subnets host application logic
- Private DB subnets isolate the database layer
- Multi-AZ design improves fault tolerance

---

## Public vs Private Subnets

Subnets are defined by routing behavior:

- **Public Subnet:** Has a route to the Internet Gateway (IGW)
- **Private Subnet:** Does NOT have a direct route to the IGW

This ensures that only intended resources are exposed to the internet.

---

## Core Components

### Internet Gateway (IGW)
- Attached to the VPC
- Enables inbound and outbound internet access for public subnets

---

### Application Load Balancer (ALB)
- Deployed across both public subnets
- Serves as the only public entry point
- Distributes incoming traffic to EC2 instances in private subnets

---

### NAT Gateway (Zonal Design)

- Deployed in **Public Subnet A (single AZ)**
- Allows private subnets to initiate outbound internet connections
- Blocks inbound internet access to private resources

#### Key Behavior:
- Private subnets in **other AZs can still route to this NAT Gateway**
- Traffic will traverse across AZs to reach it

#### Tradeoffs:
- ✅ Lower cost (single NAT Gateway)
- ❌ Cross-AZ data transfer charges
- ❌ Single point of failure if the NAT’s AZ becomes unavailable

#### Production Best Practice:
- Deploy one NAT Gateway per AZ
- Route each private subnet to a NAT in the same AZ
- Improves:
  - High availability
  - Cost efficiency (avoids cross-AZ traffic)

---

### EC2 (Application Layer)
- Runs in private app subnets
- No direct internet access
- Receives traffic only from ALB

---

### RDS (Database Layer)
- Runs in private DB subnets
- Not publicly accessible
- Configured for Multi-AZ high availability

---

## Routing Design

### Public Route Table
- `0.0.0.0/0 → Internet Gateway`
- Associated with all public subnets

### Private Route Table
- `0.0.0.0/0 → NAT Gateway`
- Associated with all private subnets

---

## Traffic Flow

### Inbound (User Request)

1. User sends request from the internet  
2. Traffic enters through Internet Gateway  
3. Routed to Application Load Balancer  
4. ALB forwards request to EC2 in private app subnets  
5. EC2 communicates with RDS in private DB subnets  
6. Response returns through ALB to the user  

---

### Outbound (Private Resources)

- EC2 → NAT Gateway → Internet  
- Used for:
  - OS updates
  - External APIs
  - Package downloads

---

## Security Design

- Only ALB is publicly accessible
- EC2 instances are isolated in private subnets
- RDS is fully private and restricted
- Security groups enforce:
  - ALB → EC2 communication
  - EC2 → RDS communication

---

## Failure Considerations

### NAT Gateway Failure
- Private subnets lose outbound internet access
- Application remains accessible via ALB
- Impacts updates and external dependencies

---

### Availability Zone Failure
- ALB routes traffic to healthy AZ
- EC2 and RDS failover (if Multi-AZ configured)
- System remains operational

---

## Key Design Decisions

- Used a **single zonal NAT Gateway** to:
  - Understand routing behavior
  - Learn cross-AZ traffic implications
  - Reduce lab costs

- Used explicit route tables instead of defaults to:
  - Gain full control over traffic flow
  - Avoid hidden AWS behavior

- Segmented subnets by tier (web/app/db) to:
  - Improve security
  - Reflect real-world architecture patterns

---

## Summary

This architecture demonstrates:

- Secure network segmentation
- Controlled internet exposure
- Understanding of AWS routing and NAT behavior
- Awareness of cost vs availability tradeoffs
- A realistic 3-tier cloud architecture design
