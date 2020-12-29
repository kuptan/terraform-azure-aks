subnets = {
  "snet-dev-bastion" = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-dev-k8s-infra/providers/Microsoft.Network/virtualNetworks/vnet-dev-k8s-infra/subnets/snet-dev-bastion"
  "snet-dev-main" = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-dev-k8s-infra/providers/Microsoft.Network/virtualNetworks/vnet-dev-k8s-infra/subnets/snet-dev-main"
}

clusters = {
  "main" = {
      cluster_name           = "main"
      subnet_name           = "main"
      cluster_version        = "1.18.8"
      kube_dashboard_enabled = true
      private_cluster_enabled= false
      cluster_admin_user     = "mainadmin"
      cluster_network = {
        network_plugin       = "azure"
        network_policy       = "calico"
        service_cidr       = "10.100.0.0/16"
        docker_bridge_cidr = "172.17.0.1/16"
        dns_service_ip     = "10.100.0.10"
        dns_prefix         = "main-dns"
        load_balancer_sku     = "Standard"
      }
      default_node_pool = {
        name               = "d4v3"
        node_count         = 2
        vm_size            = "Standard_D4_v3"
        os_disk_size_gb    = 30
        min_count          = 1
        max_count          = 6
        availability_zones = [1]
      }
      ad_rbac_enabled       = true
      ad_admins_object_ids = [
          "00000000-0000-0000-0000-000000000000",
      ]
    },
}