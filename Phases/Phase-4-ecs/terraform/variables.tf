variable "aws_region" {
  description = "AWS region for Phase 4 ECS resources."
  type        = string
  default     = "us-east-1"
}

variable "resource_prefix" {
  description = "Prefix used for Phase 4 resource names."
  type        = string
  default     = "cloud-foundations-phase4"
}

variable "common_tags" {
  description = "Common tags applied to Phase 4 resources."
  type        = map(string)
  default = {
    Project     = "cloud-foundations"
    Phase       = "phase-4-ecs"
    Environment = "lab"
    ManagedBy   = "terraform"
  }
}

