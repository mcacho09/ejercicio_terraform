# variables.tf
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "mario-secure-bucket"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}


variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "Mario"
  }
}
