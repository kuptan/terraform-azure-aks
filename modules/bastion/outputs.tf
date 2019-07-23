output "public_ip_address" {
  value = azurerm_public_ip.bastion_public_ip.ip_address
}