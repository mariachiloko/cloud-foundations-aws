# 🔵 Day 4 – Terraform Skeleton & First VPC Build

## 🔵 What I Did
- Created the initial Terraform configuration for AWS
- Added the AWS provider block and set the region to `us-east-1`
- Created my first Terraform-managed AWS resource: a VPC
- Applied the VPC in AWS using Terraform
- Updated the VPC CIDR block from `/16` to `/20`
- Re-applied the Terraform configuration with the refined CIDR choice

---

## 🔵 What I Learned
- Terraform allows me to define infrastructure as code instead of building everything manually in the AWS Console
- A provider block tells Terraform which platform it is working with
- A resource block defines the actual infrastructure Terraform should create
- A VPC is the foundation of the network and must exist before subnets, route tables, gateways, and other networking components
- CIDR sizing should be intentional and based on the actual size and purpose of the environment
- A `/20` is a better fit for this lab than a `/16` because it avoids over-allocating IP space while still leaving room for subnet growth

---

## 🔵 Key Concepts
- **Provider**: Tells Terraform which service to interact with, such as AWS
- **Resource**: The infrastructure object Terraform will create, such as a VPC
- **VPC**: A logically isolated network in AWS where resources will live
- **CIDR Block**: The IP address range assigned to the VPC
- **Terraform Apply**: The command that creates or updates real infrastructure in AWS based on the code

---

## 🔵 What Was Confusing
- Why a `/16` might be common in examples but not always the best design choice
- Understanding that a valid CIDR choice is not automatically the most intentional one
- Realizing that Terraform code should reflect design decisions I can actually explain

---

## 🔵 Clarification
- The VPC is the first networking resource because everything else depends on it
- Changing the CIDR block early in the project is the right time to do it before building dependent resources
- Right now only the VPC exists in AWS from Terraform
- Subnets, route tables, internet gateway, NAT gateway, and security groups have not been created yet
- This means the environment is still foundational and not yet a complete working network

---

## 🔵 What I Built
```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/20"

  tags = {
    Name = "main-vpc"
  }
}