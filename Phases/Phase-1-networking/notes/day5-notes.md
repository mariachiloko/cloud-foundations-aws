# 📘 Day 5 - Subnet Architecture & Multi-Tier Design

---

## 🔵 Objective

Build a segmented VPC network using Terraform by creating:
- Public subnets
- Private application subnets
- Private database subnets
- Multi-AZ design

---

## 🔵 What Was Built

### 🧱 VPC

- CIDR block: `/20`
- DNS support enabled
- DNS hostnames enabled

```hcl
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}
```

## 🔵 Key Concept: DNS in a VPC

- `enable_dns_support = true`
  - Enables AWS-provided DNS resolution inside the VPC
  - Allows instances to resolve domain names (e.g., google.com, AWS service endpoints)

- `enable_dns_hostnames = true`
  - Assigns DNS hostnames to EC2 instances
  - Required for public DNS names and internal hostname resolution

---

## 🔵 What This Solves

- Enables EC2 instances to:
  - Access the internet using domain names
  - Communicate with AWS services (S3, SSM, APIs)
  - Resolve internal resources using DNS instead of IP addresses

---

## 🔵 Real-World Usage

- Application Load Balancers (ALB) rely on DNS names
- Internal services communicate using hostnames instead of hardcoded IPs
- Private instances use DNS to reach AWS services and external endpoints

Example:
- Instead of:
  - `10.0.2.15`
- Use:
  - `app.internal`

---

## 🔵 Why This Matters

- Prevents hardcoding IP addresses (which can change)
- Supports scalable and maintainable architecture
- Required for most AWS-managed services to function correctly

---

## 🔵 What Happens If Disabled

- Instances cannot resolve domain names
- Internet access using URLs fails
- AWS services may not be reachable
- Load balancers and internal communication break

---

## 🔵 Best Practice

- Always enable both DNS support and DNS hostnames in production VPCs
- Consider this a standard configuration, not optional

---

### 🌐 Public Subnets (2)

- One per Availability Zone
- Intended for load balancer and NAT (later)
- Public IP auto-assignment disabled

---

### ⚙️ Private App Subnets (2)

- One per Availability Zone
- Intended for application layer resources

---

### 🗄️ Private DB Subnets (2)

- One per Availability Zone
- Intended for database layer
- Most restricted tier

---

## 🔵 Subnet Layout

| Tier      | AZ1          | AZ2          |
|-----------|-------------|-------------|
| Public    | 10.0.0.0/24 | 10.0.1.0/24 |
| App       | 10.0.2.0/24 | 10.0.3.0/24 |
| Database  | 10.0.4.0/24 | 10.0.5.0/24 |

- All subnets are within the `/20` VPC
- Designed for expansion

---

## 🔵 Key Concepts

### 🧠 Public vs Private

- Determined by routing, not subnet name
- Public = route to Internet Gateway
- Private = no direct internet route

---

### 🧠 Tier Separation

- App and DB are both private but serve different roles
- Separation improves security and clarity

---

### 🧠 Multi-AZ Design

- Each tier spans 2 AZs
- Provides high availability and resilience

---

### 🧠 CIDR Planning

- `/20` VPC avoids over-allocation
- `/24` subnets provide clean segmentation

---

### 🧠 Tagging Strategy

```hcl
tags = merge(
  var.common_tags,
  {
    Name = "public-subnet-az1"
    Tier = "public"
  }
)
```

- Ensures consistency across resources

---

### 🧠 Provider Versioning

```hcl
version = "~> 5.0"
```

- Allows updates within version 5
- Prevents breaking changes from version 6+

- `.terraform.lock.hcl` committed for consistency

---

### 🧠 Project Structure

```
main.tf        → resources
variables.tf   → inputs
outputs.tf     → outputs
versions.tf    → versions
```

---

## 🔵 Commands Used

```bash
terraform fmt
terraform validate
terraform init -upgrade
terraform plan
terraform apply
```

---

## 🔵 Git Workflow

```bash
git add .
git commit -m "Refactor VPC configuration to support multi-tier architecture and enforce provider version constraints"
git push origin main
```

---

## 🔵 What’s Not Done Yet

- No Internet Gateway
- No Route Tables
- No NAT Gateway
- No routing behavior yet

---

## 🔵 Common Mistakes Avoided

- Mixing app and database in same subnet
- Over-allocating CIDR blocks
- Ignoring provider versioning
- Not committing lock file
- Assuming subnet type by name

---

## 🔵 Reflection

- Initially confused about Terraform provider versions and why version 6.39.0 was being used
- Assumed that setting a version constraint would automatically override the existing version
- Learned that `.terraform.lock.hcl` locks the exact provider version and must be updated intentionally
- Encountered an error when the lock file version (6.x) did not match the constraint (`~> 5.0`)
- Discovered that `terraform init -upgrade` is required to reselect a compatible version
- Gained understanding of version constraints vs lock file behavior
- Also clarified why Terraform files are split (main.tf vs versions.tf) for better structure

## 🔵 Explanation (Interview)

I created a VPC using a /20 CIDR block and segmented it into public, application, and database subnets across two availability zones. This design supports high availability and better security through tier separation. I also implemented provider version constraints and structured the Terraform project following best practices.

---

## 🔵 Next Step

- Internet Gateway (IGW)
- Route Tables
- NAT Gateway
- Public vs Private routing