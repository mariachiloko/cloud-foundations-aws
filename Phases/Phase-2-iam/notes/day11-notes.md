# Day 11 – IAM Security Hardening & Cleanup

## What I Did
- Reviewed the Terraform-managed IAM resources created during Phase 2
- Identified that the GitHub OIDC Terraform policy was still using overly broad permissions:
  - `Action = "*"`
  - `Resource = "*"`
- Replaced the broad wildcard permissions with a more scoped IAM-focused policy
- Limited the Terraform deployment role to IAM and OIDC-related actions required for this phase
- Re-applied the Terraform configuration using:
  - `terraform fmt`
  - `terraform validate`
  - `terraform plan`
  - `terraform apply`
- Reviewed changes carefully before committing and pushing to GitHub
- Used intentional Git staging instead of blindly using `git add .`

---

# Why This Mattered

The original wildcard policy was acceptable for early testing, but it was not appropriate for a professional portfolio project long-term.

The risk of:
- `Action = "*"`
- `Resource = "*"`

is that the GitHub Actions role would effectively have administrative-level permissions if the workflow or repository were compromised.

This day focused on reducing:
- blast radius
- unnecessary permissions
- long-term security risk

This reflects real-world IAM hardening practices.

---

# Key Concepts I Strengthened

## Least Privilege
IAM permissions should only allow the exact actions required.

The goal is:
- reduce risk
- reduce accidental changes
- limit damage if credentials or workflows are compromised

---

## Blast Radius
Blast radius refers to:
> how much damage can occur if an identity or system is compromised.

Broad wildcard permissions create a very large blast radius.

Scoped permissions reduce it.

---

## OIDC vs Authorization
OIDC solves:
> secure authentication between GitHub and AWS

The IAM policy attached to the role controls:
> what GitHub is actually allowed to do after authentication

Authentication and authorization are separate concepts.

---

## Terraform IAM Security
Terraform often starts with broader permissions during initial testing.

The important engineering step is:
- revisiting permissions later
- tightening access
- documenting improvements

---

# Important Realization

I noticed that the project originally said:
> "Temporary broad permissions for Terraform (will restrict later)"

but the permissions had not actually been restricted yet.

This made me realize:
- security debt can remain if it is not intentionally revisited
- comments alone do not improve security
- real engineering requires follow-through

This was an important professional mindset shift.

---

# What Changed Technically

The original policy allowed:

{
  "Effect": "Allow",
  "Action": "*",
  "Resource": "*"
}

The updated policy now allows only specific IAM and OIDC actions needed for:
- IAM roles
- IAM policies
- OIDC providers
- policy attachments

This significantly reduced unnecessary access.

---

# What I Learned

- OIDC is modern best practice for GitHub Actions authentication
- Temporary credentials are safer than long-lived access keys
- Even with secure authentication, permissions still need least privilege
- Terraform automation should still follow security best practices
- Git commit history should reflect intentional engineering decisions

---

# Common Mistakes to Avoid

## Leaving Wildcard Permissions Forever
Temporary admin-style permissions should not remain long-term.

---

## Assuming OIDC Automatically Means Secure
OIDC improves authentication security, but permissions can still be overly broad.

---

## Blindly Using `git add .`
This can accidentally commit:
- secrets
- Terraform state
- local files

Intentional staging is safer.

---

# Commands Used

## View Git Changes

git status
git diff

---

## Terraform Validation

terraform fmt
terraform validate
terraform plan
terraform apply

---

## Git Commit

git add terraform/main.tf
git commit -m "Restrict Terraform OIDC role permissions to scoped IAM actions"
git push

---

# Interview Takeaway

I can now explain:
- why wildcard IAM permissions are dangerous
- how least privilege reduces blast radius
- how GitHub OIDC works
- the difference between authentication and authorization
- why Terraform IAM roles should be reviewed and hardened over time

---

# Final Takeaway

This day felt more like real cloud engineering work than simply following a tutorial.

The important lesson was not just:
> “Make Terraform work.”

The important lesson was:
> “Make Terraform secure and intentionally designed.”