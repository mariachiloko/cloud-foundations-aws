# Day 10 – IAM Troubleshooting & Runbooks

## What I Did
- Learned how to troubleshoot IAM permission issues
- Created an IAM troubleshooting runbook for my project
- Studied common IAM failure scenarios like AccessDenied errors
- Learned about tools like IAM Policy Simulator and Access Analyzer

## What I Learned
- IAM debugging is about identifying:
  - Who is making the request (principal)
  - What action is being attempted
  - What resource is being accessed
- AWS denies requests by default unless explicitly allowed
- Explicit deny always overrides allow
- Troubleshooting should be systematic, not guesswork
- Tools exist to simulate and analyze IAM behavior instead of blindly changing permissions

## Key Concepts
- AccessDenied: Indicates missing or blocked permissions
- Implicit Deny: No policy allows the action
- Explicit Deny: A policy explicitly blocks the action
- Policy Simulator: Tests whether an action should be allowed
- Access Analyzer: Detects unintended access or exposure

## Takeaway
I now understand that troubleshooting IAM is a structured process, not trial and error. Instead of adding broad permissions, I should analyze the request and fix only what is missing.
