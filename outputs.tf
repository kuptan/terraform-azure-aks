output "bastion_public_ip_address" {
  value = var.bastion_enabled ? module.bastion.0.public_ip_address : "NOT ENABLED"
}

output "clusters" {
  value = {
    for cluster in azurerm_kubernetes_cluster.kube_cluster :
    cluster.name => {
      id                       = cluster.id
      host                     = cluster.kube_config.0.host
      resource_group_name      = cluster.resource_group_name
      node_resource_group_name = cluster.node_resource_group
    }
  }
}

output "keyvaults" {
  value = {
    for kv in azurerm_key_vault.key_vault :
    kv.name => kv.id
  }
}
