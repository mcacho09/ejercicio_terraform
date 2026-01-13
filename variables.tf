# variables.tf

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}


variable "common_tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Owner = "Mario"
  }
}
