# SSH key generation, output is displayed at the end of the apply.
resource "tls_private_key" "terraform-ssh-keygen" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = "terraform-generated-ssh-key"
  public_key = tls_private_key.terraform-ssh-keygen.public_key_openssh
}