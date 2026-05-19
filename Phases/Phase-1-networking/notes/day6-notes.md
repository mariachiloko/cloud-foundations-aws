# 🌐 Day 6 – Internet Access + NAT + Route Tables (Terraform)

## 🧠 What We Did

Today we implemented **routing and internet access** for our VPC using Terraform.

Up until now, we had:

* A VPC
* Public and private subnets

But nothing could:

* Reach the internet (public)
* Or go outbound safely (private)

Today we fixed that by adding:

* Internet Gateway (IGW)
* NAT Gateway (with Elastic IP)
* Public Route Table
* Private Route Table
* Route Table Associations

---

## 🤔 What Confused Me (Important)

I was confused about:

* How a NAT Gateway works across Availability Zones
* The difference between **zonal vs regional NAT**
* Whether a NAT in one AZ can serve subnets in another AZ

### What I Thought (Wrong)

* NAT could only serve the AZ it was created in
* Regional NAT meant AWS automatically creates one NAT per AZ

---

## 💡 What Clicked

* A NAT Gateway is **physically in ONE AZ**
* BUT:
  👉 Any subnet in the VPC can route to it

So:

* Private Subnet B (AZ-B) → can still use NAT in AZ-A
* Traffic just crosses AZs

---

### 🧠 Real Understanding

👉 Zonal NAT = YOU control placement
👉 Regional NAT = AWS abstracts/handles it

But:

❗ NAT is always zonal under the hood

---

## 🔑 Key Concepts

### Public vs Private Subnets (IMPORTANT)

A subnet is **NOT** public because of its name.

👉 It is public if:

```id="p1"
0.0.0.0/0 → Internet Gateway
```

👉 It is private if:

```id="p2"
0.0.0.0/0 → NAT Gateway
```

---

### Internet Gateway (IGW)

* Attached to the VPC
* Allows:

  * inbound internet traffic
  * outbound internet traffic

Used by:

* Public subnets

---

### NAT Gateway

* Lives in a **public subnet**
* Uses an **Elastic IP**
* Allows:

  * private subnets → internet (outbound only)

🚫 Blocks:

* inbound internet traffic to private resources

---

### Route Tables

A route table is just:
👉 instructions for where traffic goes

We created:

#### Public Route Table

```id="p3"
0.0.0.0/0 → IGW
```

#### Private Route Table

```id="p4"
0.0.0.0/0 → NAT Gateway
```

---

### Route Table Associations

Route tables do nothing unless attached to subnets.

We associated:

* Public subnets → Public Route Table
* Private subnets → Private Route Table

---

## 🏗️ Architecture Decisions

### Single NAT Gateway (Zonal Design)

We used:

* 1 NAT Gateway
* In Public Subnet A

---

### Why?

✅ Lower cost (important for labs)
✅ Simpler to understand
✅ Helps learn routing behavior deeply

---

### Tradeoffs

❌ Cross-AZ traffic (extra cost)
❌ Single point of failure

---

### Production Best Practice

* 1 NAT Gateway per AZ
* Each private subnet uses NAT in its own AZ

---

## 🔁 Traffic Flow (CRITICAL)

### Inbound (User → App)

```id="p5"
Internet
  ↓
Internet Gateway
  ↓
Public Subnet (ALB later)
  ↓
Private App Subnet (EC2 later)
  ↓
Private DB Subnet (RDS later)
```

---

### Outbound (Private → Internet)

```id="p6"
Private Subnet
  ↓
NAT Gateway
  ↓
Internet Gateway
  ↓
Internet
```

---

## ⚙️ Terraform Resources Added

We added:

* `aws_internet_gateway`
* `aws_eip`
* `aws_nat_gateway`
* `aws_route_table` (public + private)
* `aws_route`
* `aws_route_table_association` (6 total)

---

## 📤 Outputs Added

* internet_gateway_id
* nat_gateway_id
* public_route_table_id
* private_route_table_id

👉 Helps verify infrastructure after apply

---

## 🧠 What I Learned

* Public vs private is defined by **routing**, not naming
* NAT Gateway must be in a **public subnet**
* One NAT can serve multiple AZs (with tradeoffs)
* Route tables control everything
* Terraform should be the source of truth (not manual + code mixed)

---

## ⚠️ Common Mistakes

❌ NAT in private subnet
❌ Missing route table associations
❌ Private route table pointing to IGW
❌ Assuming subnet is public by name
❌ Not reviewing terraform plan

---

## 💬 How I Would Explain This

“I created an Internet Gateway for public access and a NAT Gateway for private subnet outbound traffic. Then I used route tables to control traffic flow. I used a single zonal NAT Gateway for cost and learning purposes, understanding that subnets in other AZs can still use it but with tradeoffs.”

---

## 🚀 What This Unlocks

Now the network can:

✅ Serve public traffic
✅ Allow private resources outbound access
✅ Support real workloads (EC2, ALB, RDS next)

---

## 🔥 Big Picture

Before today:
👉 We had structure

After today:
👉 We have **behavior**

This is when the VPC becomes a real network.
