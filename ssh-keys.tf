resource "tls_private_key" "k8s_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}
