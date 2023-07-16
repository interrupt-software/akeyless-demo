variable "project-name" {
  type = string
  default = "trendy-tabby"  
}

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  default     = "trendy-tabby"
}

variable "region" {
  description = "The region where the resources are created."
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "CIDR block for Public Subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnets_cidr" {
  description = "CIDR block for Private Subnet"
  default     = "10.0.10.0/24"
}

variable "instance_type" {
  description = "Specifies the AWS instance type."
  default     = "t2.small"
}

variable "database_username" {
  sensitive = true
  default   = "postgres"
}

variable "database_password" {
  sensitive = true
  default   = "correct-horse-battery-staple"
}

# variable "vpc_id" {
# }
