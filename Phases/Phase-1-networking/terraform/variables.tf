variable "aws_region" {
  description = "AWS region for the lab"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the main VPC"
  type        = string
  default     = "10.0.0.0/20"
}

variable "public_subnet_az1_cidr" {
  description = "CIDR block for public subnet in AZ1"
  type        = string
  default     = "10.0.0.0/24"
}

variable "public_subnet_az2_cidr" {
  description = "CIDR block for public subnet in AZ2"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_app_subnet_az1_cidr" {
  description = "CIDR block for private app subnet in AZ1"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_app_subnet_az2_cidr" {
  description = "CIDR block for private app subnet in AZ2"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_db_subnet_az1_cidr" {
  description = "CIDR block for private database subnet in AZ1"
  type        = string
  default     = "10.0.4.0/24"
}

variable "private_db_subnet_az2_cidr" {
  description = "CIDR block for private database subnet in AZ2"
  type        = string
  default     = "10.0.5.0/24"
}

variable "common_tags" {
  description = "Common tags applied to resources"
  type        = map(string)
  default = {
    Project     = "cloud-foundations"
    Phase       = "phase-1-networking"
    Environment = "lab"
    ManagedBy   = "terraform"
  }
}