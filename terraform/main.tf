provider "aws" {
  region = var.aws_region
}

/*
# Define the key pair
resource "aws_key_pair" "ansible_key" {
  key_name   = "ansible-key"
  public_key = file(var.public_key_path)
}
*/
# Security group to allow SSH
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Create 3 Ubuntu EC2 instances
resource "aws_instance" "Ansible_project_instances" {
  count         = 2
  ami           = var.ami_id
  instance_type = var.instance_type
#  key_name      = aws_key_pair.ansible_key.key_name
  security_groups = [
    aws_security_group.allow_ssh.name
  ]

  tags = {
    Name = "ubuntu-instance-${count.index + 1}"
  }

  # User data script to set up the instances
  user_data = <<-EOF
            #!/bin/bash
            sudo apt-get update -y
            sudo apt-get upgrade -y
            if [ ${count.index} == 0 ]; then
              # Install Ansible on the first instance
              sudo apt-get install -y ansible
            fi
        EOF
  provisioner "local-exec" {
    command = "echo '' > ./ansible/inventory.ini; echo '[]' > ./ansible/inventory.ini ;echo '${self.public_ip}' ansible_user=devops ansible_ssh_private_key_file=~/.ssh/id_rsa>> ./ansible/inventory.ini"
    
  }

}

