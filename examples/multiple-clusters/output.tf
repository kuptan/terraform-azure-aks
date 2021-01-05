output "clusters" {
  value = {
    for cluster in module.aks-cluster :
    cluster.name => {
      id                       = cluster.id
      host                     = cluster.host
      fqdn                     = cluster.fqdn
      resource_group_name      = cluster.resource_group_name
      node_resource_group_name = cluster.node_resource_group_name
    }
  }
}