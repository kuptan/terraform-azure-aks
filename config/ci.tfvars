subnets = {
  "snet-lab-bastion" = "/subscriptions/a68c61a6-aaae-408d-b703-1d88a0610144/resourceGroups/rg-lab-k8s-infra/providers/Microsoft.Network/virtualNetworks/vnet-lab-k8s-infra/subnets/snet-lab-bastion"
  "snet-lab-main" = "/subscriptions/a68c61a6-aaae-408d-b703-1d88a0610144/resourceGroups/rg-lab-k8s-infra/providers/Microsoft.Network/virtualNetworks/vnet-lab-k8s-infra/subnets/snet-lab-main"
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
          "06eb1509-cc1f-4aae-9de3-2fc22f72b34f",
      ]
    },
}