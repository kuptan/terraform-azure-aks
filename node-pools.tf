resource "azurerm_kubernetes_cluster_node_pool" "k8s_additional_node_pools" {
  for_each = var.additional_node_pools

  kubernetes_cluster_id = azurerm_kubernetes_cluster.kube_cluster.id
  name                  = each.key
  node_count            = each.value.node_count
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  vm_size               = each.value.vm_size
  enable_auto_scaling   = each.value.auto_scaling_enabled
  os_type               = each.value.os_type
  os_disk_size_gb       = each.value.os_disk_size_gb
  availability_zones    = each.value.availability_zones
  vnet_subnet_id        = each.value.subnet_id
}