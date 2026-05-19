# 🔵 Day 3 – Safe Local Setup & Security Basics

## 🔵 What I Did
- Verified Terraform and AWS CLI were installed and working  
- Configured AWS CLI using local credentials (not stored in the project)  
- Ran a command to confirm AWS connection was successful  
- Initialized Terraform in the project folder  
- Reviewed `.gitignore` to make sure sensitive files are excluded  
- Checked Git to confirm no secrets or state files are being tracked  
- Created `terraform.tfvars.example` for safe configuration sharing  

---

## 🔵 What I Learned
- AWS credentials should never be stored in project files  
- Terraform uses a state file (`.tfstate`) to track infrastructure  
- The `.gitignore` file is critical for protecting sensitive data  
- Just because something is set up doesn’t mean it’s correct — always verify  
- Git will track files unless explicitly told not to  

---

## 🔵 Key Concepts
- **Terraform State**: A file that keeps track of what resources Terraform manages  
- **AWS CLI Profile**: A secure way to authenticate locally without hardcoding credentials  
- **.gitignore**: A file that tells Git what NOT to track  
- **tfvars**: Used to store variable values (should not be committed)  
- **tfvars.example**: A safe template for sharing configuration  

---

## 🔵 What Was Confusing
- Thinking setup was already complete without verifying it  
- Understanding where AWS credentials are actually stored  
- Realizing `.gitignore` does not remove files that are already tracked  

---

## 🔵 Clarification
- AWS credentials are stored locally in `~/.aws/credentials`, not in the project  
- `.gitignore` only prevents NEW files from being tracked  
- If something sensitive is already tracked, it must be manually removed from Git  
- The project should always be safe to make public  

---

## 🔵 Takeaway
I now understand how to securely set up my local environment for Terraform and AWS. I also understand the importance of protecting sensitive data and verifying my setup instead of assuming everything is correct.