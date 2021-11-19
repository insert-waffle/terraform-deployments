output "public_key" {
  description = "Our public SSH key"
  value       = tls_private_key.terraform-ssh-keygen.public_key_openssh
}

output "private_key" {
  description = "Our private SSH key"
  value       = tls_private_key.terraform-ssh-keygen.private_key_pem
  sensitive   = true
}

output "instance_ip_addr" {
  description = "IP address of our EC2 instance"
  value       = aws_instance.autodeploy-webserver.public_ip
}
