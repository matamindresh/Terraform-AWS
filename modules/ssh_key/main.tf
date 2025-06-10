resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated" {
  key_name   = "jenkins-generated-key"
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.example.private_key_pem
  filename        = "${path.module}/jenkins-key.pem"
  file_permission = "0400"
}

output "key_name" {
  value = aws_key_pair.generated.key_name
}

