variable "aws_region" {
  description = "AWS region for Phase 3 Lambda resources"
  type        = string
  default     = "us-east-1"
}

variable "resource_prefix" {
  description = "Prefix used for Phase 3 resource names."
  type        = string
  default     = "cloud-foundations-phase3"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function used in Phase 3."
  type        = string
  default     = "phase3-hello-function"
}

variable "api_name" {
  description = "Name of the HTTP API used in Phase 3."
  type        = string
  default     = "phase3-hello-api"
}

variable "api_stage_name" {
  description = "HTTP API stage name."
  type        = string
  default     = "dev"
}

variable "lambda_timeout" {
  description = "Lambda timeout in seconds."
  type        = number
  default     = 5
}

variable "lambda_memory_size" {
  description = "Lambda memory allocation in MB."
  type        = number
  default     = 128
}

variable "log_retention_days" {
  description = "CloudWatch log retention for the Lambda log group."
  type        = number
  default     = 7
}

variable "common_tags" {
  description = "Common tags applied to Phase 3 resources."
  type        = map(string)
  default = {
    Project     = "cloud-foundations"
    Phase       = "phase-3-serverless-lambda"
    Environment = "lab"
    ManagedBy   = "terraform"
  }
}
