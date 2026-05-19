# Day 2 – AWS Networking & Architecture Design

## What I Did
- Learned core AWS networking concepts (VPC, subnets, route tables, IGW, NAT, security groups)
- Wrote definitions in my own words to understand each component
- Designed a 3-tier AWS architecture (public + private subnets)
- Created an architecture diagram showing traffic flow and system layout
- Added documentation explaining traffic flow, security design, and failure scenarios
- Discussed real-world scenarios with a mentor to test my understanding

## What I Learned
- A VPC is a logically isolated network where I control IP ranges and traffic
- Subnets are used to organize resources and exist within a single Availability Zone
- A subnet is public or private based on its route table, not its name
- Internet Gateways allow communication between the VPC and the internet
- NAT Gateways allow private resources to access the internet without being exposed
- Security groups act as stateful firewalls at the resource level
- Proper architecture design keeps application and database layers private
- Troubleshooting networking issues requires understanding traffic flow, not just definitions

## Key Concepts
- VPC: A private network in AWS where all resources live
- Subnet: A smaller network inside a VPC used to organize resources
- Public Subnet: Has a route to an Internet Gateway
- Private Subnet: Does not have a route to an Internet Gateway
- Internet Gateway (IGW): Enables internet access for public resources
- NAT Gateway: Enables outbound internet access for private resources
- Route Table: Controls where network traffic is directed
- Security Group: Stateful firewall attached to resources controlling traffic

## Stateful vs Stateless
- Security Groups are **stateful**, meaning:
  - If traffic is allowed outbound, the return traffic is automatically allowed inbound
  - This is why outbound traffic is allowed by default and responses are not blocked
- Network ACLs (not used yet) are **stateless**, meaning:
  - You must explicitly allow both inbound and outbound traffic
- Because security groups are stateful, outbound traffic from instances typically works unless explicitly restricted

## Traffic Flow (Important)
### Inbound Traffic
Internet → Internet Gateway → Load Balancer → EC2 → RDS

### Outbound Traffic
EC2 → NAT Gateway → Internet Gateway → Internet

## 3-Tier Architecture Understanding
- Load Balancer (Web Tier) → Public Subnet (needs internet access)
- Application (App Tier) → Private Subnet (no direct internet access)
- Database (DB Tier) → Private Subnet (most restricted layer)

- Only the Load Balancer should be publicly accessible
- Application and database layers should remain private

## What Was Confusing
- Understanding what actually makes a subnet public vs private
- Figuring out how NAT Gateway works compared to public IPs
- Visualizing how traffic flows through multiple components
- Designing a clean diagram while keeping architecture accurate
- Knowing what to check first when something breaks (security vs routing)

## Clarification
- A subnet is public only if its route table includes a route to an Internet Gateway
- NAT Gateway allows outbound traffic only and prevents inbound connections
- NAT Gateway must be placed in a public subnet and relies on the Internet Gateway
- Private instances use NAT for outbound access (updates, API calls, etc.)
- If something cannot reach the internet, the most likely issue is the route table
- Security groups allow all outbound traffic by default and are rarely the cause of outbound failures

## Troubleshooting Mindset (Key Lesson)
When a private resource cannot reach the internet, check in this order:

1. Route Table (most common issue)
2. NAT Gateway configuration
3. NAT placement (must be in public subnet)
4. Internet Gateway attachment
5. Security groups (last, since outbound is allowed by default)

## Takeaway
I now understand how AWS networking components work together to create a secure architecture. More importantly, I learned how to think through traffic flow and troubleshoot issues by following the path traffic takes rather than guessing which component is wrong.