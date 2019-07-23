resource "tls_private_key" "k8s_ssh_key" {
  for_each = var.clusters

  algorithm = "RSA"
  rsa_bits  = "2048"
}
