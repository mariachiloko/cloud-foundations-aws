Day 12 – Phase 2: IAM Review, Terraform Standards, Project Structure, and OIDC Troubleshooting

What I Did

* Reviewed the overall structure of Phase 2 and discussed how the project should be standardized moving forward.
* Identified a problem where files were being assumed to exist because they existed in another phase.
* Added a new project rule to separate:
    * confirmed existing files,
    * standard files that should exist,
    * and intentionally added files.
* Discussed why Terraform project structure should be planned at the beginning of a phase instead of adding files unexpectedly later.
* Reviewed the purpose of:
    * versions.tf
    * outputs.tf
    * terraform.tfvars.example
* Discussed AWS provider version consistency between phases.
* Discussed why major provider upgrades should not happen casually.
* Reviewed how Terraform variables, tfvars files, and outputs relate to each other.
* Confirmed that Phase 1 currently works without a real terraform.tfvars because the variables already contain defaults.
* Confirmed that terraform.tfvars.example still provides value even when a real terraform.tfvars does not exist.
* Troubleshot a GitHub Actions OIDC authentication failure after migrating IAM resources from manual creation to Terraform.
* Reviewed how GitHub Actions uses OpenID Connect (OIDC) to assume an AWS IAM role without access keys.
* Verified that the GitHub repository variable AWS_ROLE_ARN existed and pointed to an IAM role.
* Compared the Terraform-created IAM role ARN with the ARN stored in GitHub repository variables.
* Reviewed the IAM trust policy conditions used for GitHub OIDC.
* Learned that GitHub Actions workflows do not care whether a role was created manually or through Terraform — they only care about the exact role ARN and trust policy.
* Used Codex to help harden and debug the Terraform-managed OIDC configuration.
* Updated the Terraform trust policy to use stricter claim validation:
    * exact repository matching,
    * exact branch matching,
    * and exact audience matching.
* Added Terraform variable validation for GitHub repository formatting.
* Added Terraform outputs to display the expected GitHub OIDC sub claim.
* Added workflow debugging output to make future OIDC troubleshooting easier.
* Discovered that the GitHub repository variable was still pointing to a slightly different IAM role ARN than the Terraform-managed role.
* Corrected the ARN mismatch, after which the GitHub Actions workflow successfully authenticated to AWS.

⸻

What I Learned

* Infrastructure projects need consistent standards and structure across phases.
* Terraform files should not be assumed to exist just because another phase used them.
* New files should be intentionally added and documented.
* variables.tf defines supported inputs for Terraform.
* Variables can contain default values, allowing Terraform to run without a real terraform.tfvars.
* terraform.tfvars.example is mainly used to:
    * document configurable values,
    * demonstrate professional Terraform structure,
    * and provide safe example overrides.
* terraform.tfvars.example does NOT need to match an existing real terraform.tfvars.
* outputs.tf displays useful values after infrastructure is created and is separate from variable configuration.
* Provider versions should be checked before upgrading because major versions can introduce breaking changes.
* GitHub Actions OIDC failures can occur even when the IAM role exists if the trust relationship conditions do not match GitHub’s token claims.
* OIDC authentication depends heavily on exact matching:
    * repository name,
    * branch,
    * role ARN,
    * and token claim formatting.
* GitHub repository variables can continue referencing old IAM role ARNs after migrating infrastructure to Terraform.
* Terraform does not automatically change an IAM role ARN unless the role name itself changes.
* IAM trust policies are separate from IAM permission policies:
    * trust policies control WHO can assume the role,
    * permission policies control WHAT the role can do after assumption.
* GitHub Actions workflows using OIDC require:

permissions:
  id-token: write
  contents: read

or AWS will reject the authentication request.

⸻

Key Concepts

variables.tf

Defines what input variables Terraform supports.

Example:

* region
* CIDR ranges
* tags
* GitHub repository name
* GitHub branch name

Variables can optionally contain defaults.

⸻

terraform.tfvars

Optional local override file containing real values.

Usually gitignored.

Not required when defaults already exist.

⸻

terraform.tfvars.example

Safe example file committed to GitHub.

Used to:

* document supported overrides,
* show expected formatting,
* and demonstrate Terraform standards.

Should never contain secrets.

⸻

outputs.tf

Displays useful infrastructure values after deployment.

Examples:

* VPC ID
* subnet IDs
* route table IDs
* security group IDs
* expected GitHub OIDC sub claim

Outputs are not inputs and do not belong in tfvars files.

⸻

Terraform Defaults

If a variable contains a default value, Terraform automatically uses it unless overridden.

Example:

variable "aws_region" {
  default = "us-east-1"
}

This means Terraform can work without a real terraform.tfvars.

⸻

Provider Versioning

Terraform provider versions should be intentionally managed.

Major upgrades (such as AWS provider 5.x → 6.x) should not happen casually because they may introduce breaking changes.

⸻

OIDC Trust Policy

An IAM trust policy controls which identities are allowed to assume an IAM role.

For GitHub Actions OIDC, AWS evaluates claims inside the GitHub token.

Important claims include:

* aud
* repository
* sub

Example:

repo:mariachiloko/cloud-foundations-aws:ref:refs/heads/main

If the claims do not match exactly, AWS denies:

sts:AssumeRoleWithWebIdentity

⸻

What I Was Working Through

* Why terraform.tfvars.example is still useful even when no real terraform.tfvars exists.
* Why example files should reflect actual Terraform variables instead of assumed variables.
* Why Terraform project structure needs to be standardized intentionally.
* Why provider versions should be verified before changing them across phases.
* Why GitHub Actions OIDC can fail even when the IAM role exists.
* Understanding the difference between:
    * role ARN problems,
    * trust policy problems,
    * and IAM permission policy problems.
* Understanding that GitHub Actions workflows only care about:
    * the exact role ARN,
    * and whether AWS trust conditions match the incoming GitHub token.

⸻

Decisions Made

* Do not assume files exist across phases unless confirmed.
* Future phases should begin with a defined project structure standard.
* terraform.tfvars.example should contain safe example values matching actual variables.
* terraform.tfvars should only exist when real local overrides are needed.
* Do not upgrade Terraform provider versions without checking the current lockfile and project state first.
* GitHub OIDC trust policies should use strict repository and branch matching instead of broad wildcards whenever possible.
* Continue using OIDC instead of AWS access keys for GitHub Actions authentication.
* Add Terraform validation and outputs that make IAM/OIDC troubleshooting easier.

⸻

Interview Explanation

A simple explanation:

“I learned that Terraform projects need intentional structure and version management, not just working code. I reviewed how variables, outputs, and tfvars files interact and learned why example tfvars files are useful even when default values already exist. I also troubleshot a GitHub Actions OIDC authentication issue by reviewing IAM trust policies, GitHub token claims, and role ARN configuration. I learned how AWS validates GitHub OIDC tokens using exact repository and branch matching.”

⸻

Portfolio Takeaway

This day improved both the engineering maturity and operational realism of the project.

Instead of only focusing on building resources, I focused on:

* consistency,
* maintainability,
* Terraform standards,
* secure CI/CD authentication,
* IAM troubleshooting,
* and preventing project structure drift across phases.

I also gained real-world troubleshooting experience by diagnosing and fixing an OIDC authentication failure between GitHub Actions and AWS IAM after migrating resources from manual configuration to Terraform-managed infrastructure.