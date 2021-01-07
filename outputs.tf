output "resource_group_name" {
  value = azurerm_kubernetes_cluster.kube_cluster.resource_group_name
}

output "node_resource_group_name" {
  value = azurerm_kubernetes_cluster.kube_cluster.node_resource_group
}

output "name" {
  value = azurerm_kubernetes_cluster.kube_cluster.name
}

output "id" {
  value = azurerm_kubernetes_cluster.kube_cluster.id
}

output "fqdn" {
  value = azurerm_kubernetes_cluster.kube_cluster.kube_config.0.host
}

output "host" {
  value = azurerm_kubernetes_cluster.kube_cluster.kube_config.0.host
}

output "private_ssh_key" {
  sensitive = true
  value     = tls_private_key.k8s_ssh_key.private_key_pem
}

output "public_ssh_key" {
  sensitive = true
  value     = tls_private_key.k8s_ssh_key.public_key_openssh
}

output "azure_ad_admin_group" {
  value = var.azure_ad.rbac_enabled ? azuread_group.admin.0.name : "NOT SET"
}