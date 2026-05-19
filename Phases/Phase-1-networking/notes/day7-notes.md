# 🌐 Day 7 – Security Groups (Firewall of AWS)

---

## 🔵 What We Did
- Created **Security Groups** for our VPC
- Built:
  - Public Security Group (for internet-facing resources)
  - Private Security Group (for internal resources only)
- Applied rules to control:
  - Inbound traffic (what can come in)
  - Outbound traffic (what can leave)
- Implemented this both:
  - Manually in AWS Console
  - Using Terraform

---

## 🔵 Key Concepts

### 🛡️ What is a Security Group?
A Security Group is a **virtual firewall** attached to resources (like EC2 instances) that controls traffic.

- Controls:
  - Inbound traffic (incoming)
  - Outbound traffic (outgoing)

---

### 🔄 Stateful Behavior (VERY IMPORTANT)
Security Groups are **stateful**, meaning:

- If inbound traffic is allowed → response traffic is automatically allowed out
- If outbound traffic is allowed → response traffic is automatically allowed in

👉 You do NOT need to create return rules

---

### 🌐 What is TCP?
TCP (Transmission Control Protocol) is a **reliable communication protocol**.

- Ensures:
  - Data is delivered
  - Data is in order
  - Nothing is missing

Used for:
- HTTP (port 80)
- HTTPS (port 443)
- SSH (port 22)

👉 Most real-world applications use TCP because reliability matters

---

### ⚠️ What is protocol = "-1"?
This means:

👉 **Allow ALL protocols**

Includes:
- TCP
- UDP
- ICMP (ping)
- Everything else


---

### 🔐 Ports vs Protocols (IMPORTANT)

- **Protocol** = how data communicates (TCP, UDP, etc.)
- **Port** = what service is being accessed

Example:

protocol  = "tcp"  
from_port = 80  
to_port   = 80  

👉 Means: allow HTTP traffic

---

### 🌍 Public vs Private Access

#### Public Security Group
- Allows traffic from:
  - 0.0.0.0/0 (the internet)
- Example:
  - HTTP (port 80)
- Used for:
  - Public-facing resources (like load balancers or web servers)

---

#### Private Security Group
- Does NOT allow traffic from the internet
- Only allows traffic from:
  - Another Security Group (NOT CIDR)

Example:

security_groups = [aws_security_group.public_sg.id]

Used for:
- App servers
- Databases

---

### 🔗 Security Group Referencing (IMPORTANT)

❌ Less secure:

cidr_blocks = ["10.0.0.0/16"]

✅ More secure:

security_groups = [aws_security_group.public_sg.id]

👉 This ensures:
- Only approved AWS resources can communicate
- Not the entire subnet

---

### ❌ Why NOT Use “Allow Everything”

protocol  = "-1"  
from_port = 0  
to_port   = 0  
cidr_blocks = ["0.0.0.0/0"]

This allows:
- All ports
- All protocols
- From anywhere

🚨 This is dangerous because:
- Exposes SSH, RDP, databases, etc.
- Makes your system vulnerable to attacks

🧱 Why We Do This in Private SG

Because inside your architecture:

👉 The public layer is already filtered

👉 Why allow all internally?

Because:
	•	App servers may need multiple ports
	•	You don’t want to constantly update rules during development
	•	It simplifies internal communication

🧠 The Principle Behind It

👉 Trust boundary
	•	Internet = untrusted → restrict heavily
	•	Internal SG = semi-trusted → more flexible
  
---

### ✅ Least Privilege Principle

Only allow:
- The exact port
- From the exact source
- For the exact purpose

Example:

protocol  = "tcp"  
from_port = 80  
to_port   = 80  
cidr_blocks = ["0.0.0.0/0"]

👉 Only HTTP allowed — nothing else

---

## 🔵 Why This Matters (Real-World)

Security Groups enforce **secure architecture design**:

- Public layer → exposed to internet
- Private layer → protected internally

This is the foundation of:
- 3-tier architecture
- Cloud security best practices

---

## 🔵 What Was Confusing

- Difference between:
  - Route Tables vs Security Groups
- Why we don’t just allow all traffic (“anywhere”)
- What TCP actually means
- What protocol = "-1" means

---

## 🔵 Clarifications

### Route Tables vs Security Groups

| Feature | Route Table | Security Group |
|--------|------------|---------------|
| Purpose | Controls traffic flow (where it goes) | Controls access (what is allowed) |
| Example | Sends traffic to internet | Allows port 80 |

👉 Route Tables = **path**  
👉 Security Groups = **permission**

---

### Why Not “Anywhere”?

- “Anywhere” = opens ALL ports and protocols
- Not secure
- Not realistic

👉 Instead, we allow only what is needed (like HTTP)

---

### TCP vs "-1"

| Setting | Meaning |
|--------|--------|
| "tcp" | Only TCP traffic |
| "-1" | All protocols allowed |

---

## 🔵 Takeaway

Security Groups are one of the **most important security layers in AWS**.

- They are **stateful**
- They control **access**, not routing
- They should follow **least privilege**
- Avoid using:
  - 0.0.0.0/0 unless necessary
  - "-1" unless tightly controlled

---

## 🔵 Real-World Mental Model

Think of it like a building:

- Route Tables = roads to the building
- Security Groups = security guards at the doors

Even if someone can reach the building…
👉 They still need permission to enter

---

## 🔵 What I’d Say in an Interview

“I used Security Groups to enforce least privilege. I allowed only HTTP traffic for public access and restricted internal communication using security group references instead of CIDR blocks. I avoided using open rules like protocol -1 to reduce unnecessary exposure.”