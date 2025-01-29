variable "aws_region" {
  default = "eu-west-2" # Update as needed
}

# Use the latest Ubuntu AMI for the selected region
variable "ami_id" {
  default = "ami-091f18e98bc129c4e" # Example: Ubuntu 20.04 LTS in us-east-1
}

variable "instance_type" {
  default = "t2.micro" # Free-tier eligible instance type
}

variable "public_key_path" {
  description = "Path to your public SSH key"
  default     = "~/.ssh/id_rsa.pub"
}