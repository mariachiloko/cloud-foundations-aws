# Day 4 – IAM Policies

## What I Did
- Created a custom IAM policy using JSON in the AWS Console  
- Defined specific actions and resources instead of using broad permissions  
- Attached the policy to an existing IAM user/role  
- Tested what actions were allowed and what were denied  

## What I Learned
- IAM policies are what actually control access in AWS  
- Users and roles do not have permissions unless a policy is attached  
- Permissions must be explicitly allowed, otherwise they are denied  
- Least privilege means giving only the exact access required  
- Blast radius is the amount of damage that can happen if access is too broad  

## Key Concepts
- IAM Policy: A JSON document that defines permissions  
- Effect: Whether access is allowed or denied  
- Action: The specific AWS operation being controlled  
- Resource: The AWS resource the action applies to  
- Least Privilege: Only giving the permissions needed  
- Blast Radius: The potential impact if an identity is compromised  

## Takeaway
I understand that IAM policies are what define access in AWS and that writing them carefully is critical for security. I also understand how limiting permissions reduces risk and prevents large-scale damage.
