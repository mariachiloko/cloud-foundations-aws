# Day 9 – IAM Documentation & Architecture

## What I Did
- Reviewed my IAM setup including users, roles, and policies
- Focused on understanding how trust relationships work
- Worked on documenting IAM structure and flow in my project
- Updated architecture to reflect IAM components and access flow

## What I Learned
- IAM is about controlling who can do what in AWS
- Roles are preferred over users because they provide temporary credentials
- Trust policies define who is allowed to assume a role
- Identity policies define what actions are allowed once the role is assumed
- IAM design is just as important to document as networking

## Key Concepts
- IAM Role: An identity that can be assumed to gain permissions
- Trust Policy: Defines who can assume a role
- Identity Policy: Defines what actions are allowed
- Least Privilege: Only granting the minimum permissions required
- OIDC: Allows external systems (like GitHub) to assume roles securely without access keys

## Takeaway
I now understand how IAM components connect together and why roles and trust relationships are critical for secure access in AWS. I also understand that being able to clearly explain IAM design is just as important as building it.