# AWS Networking Architecture Notes

These notes reflect my understanding of AWS networking fundamentals, including VPC design, subnet behavior, routing, and secure architecture patterns.

✅ What is a VPC?

A VPC is a virtual private cloud. It is like having your own private data center in AWS where you control networking, IP ranges, and traffic. It is logically isolated from other networks in AWS. 

✅ What is a subnet?

A subnet is a smaller network inside a VPC where you organize resources like servers and applications. Subnets are used to separate and control access between different parts of your system. Subnets exist in one Availability Zone.

✅ What makes a subnet public vs private?

A subnet is not inherently public or private by name. It is determined by its route table. If the route table includes a route to an Internet Gateway, the subnet is public.If it does not include that route, the subnet is private.

✅ What does a route table do?

A route table controls how traffic flows within a VPC by defining where network traffic is directed. It determines whether traffic goes to the internet, stays inside the VPC, or goes through other resources like a NAT Gateway.

✅ What does a NAT Gateway do?

A NAT Gateway allows resources in a private subnet to access the internet for outbound traffic while preventing inbound connections from the internet.

✅ What is a security group?

A security group is a stateful firewall attached to AWS resources (like EC2 instances) that controls inbound and outbound traffic based on rules such as ports, protocols, and IP ranges. For example, a security group might allow HTTP (port 80) from the internet but only allow database access from the application server.

## Traffic Flow Example

1. User sends request from internet
2. Traffic enters VPC through Internet Gateway
3. Request reaches load balancer in public subnet
4. Load balancer forwards request to application in private subnet
5. Application communicates with database in private subnet
6. Response flows back through load balancer to user

## Why Not Place App in Public Subnet

Placing application servers directly in a public subnet exposes them to the internet, increasing the attack surface. Best practice is to use a load balancer in a public subnet as the entry point and keep application servers in private subnets. This allows better traffic control, reduces direct exposure, and improves overall security.

## Why Use a NAT Gateway

A NAT Gateway allows resources in private subnets to access the internet for outbound traffic without exposing them to inbound connections. Assigning public IPs would allow both inbound and outbound traffic, increasing the attack surface. Using NAT enforces a more secure design by separating outbound access from inbound exposure.

## Common Failure Scenario: Route Table Misconfiguration

If a public subnet does not have a route to the Internet Gateway, users cannot access the application.

If a private subnet does not have a route to the NAT Gateway, instances cannot reach the internet for updates or API calls.

These failures are caused by incorrect traffic paths, not by issues with the resources themselves.

## Architecture Diagram

![Architecture Diagram](./architecture-diagram.png)

This diagram represents a secure AWS architecture where only the load balancer is publicly accessible, while application and database layers remain private.