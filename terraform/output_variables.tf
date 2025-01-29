output "ec2_instance_public_ips" {
  description = "Public IPs of all EC2 instances"
  value       = aws_instance.Ansible_project_instances[*].public_ip
}

output "ansible_instance_ip" {
  description = "Public IP of the instance with Ansible installed"
  value       = aws_instance.Ansible_project_instances[0].public_ip
}
