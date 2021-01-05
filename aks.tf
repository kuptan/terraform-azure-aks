resource "azurerm_kubernetes_cluster" "kube_cluster" {
  name                    = "k8s-${var.environment}-${var.name}"
  location                = azurerm_resource_group.cluster_rg.location
  resource_group_name     = azurerm_resource_group.cluster_rg.name
  dns_prefix              = var.name
  kubernetes_version      = var.cluster_version
  private_cluster_enabled = var.private_cluster_enabled

  addon_profile {
    kube_dashboard {
      enabled = var.kube_dashboard_enabled
    }
  }

  linux_profile {
    admin_username = var.name

    ssh_key {
      key_data = tls_private_key.k8s_ssh_key.public_key_openssh
    }
  }

  network_profile {
    network_plugin     = var.cluster_network.network_plugin
    network_policy     = var.cluster_network.network_policy
    service_cidr       = var.cluster_network.service_cidr
    docker_bridge_cidr = var.cluster_network.docker_bridge_cidr
    dns_service_ip     = var.cluster_network.dns_service_ip
    load_balancer_sku  = var.cluster_network.load_balancer_sku
  }

  default_node_pool {
    name                = var.default_node_pool.name
    node_count          = var.default_node_pool.node_count
    min_count           = var.default_node_pool.min_count
    max_count           = var.default_node_pool.max_count
    vm_size             = var.default_node_pool.vm_size
    type                = var.default_node_pool.type
    enable_auto_scaling = var.default_node_pool.enable_auto_scaling
    os_disk_size_gb     = var.default_node_pool.os_disk_size_gb
    vnet_subnet_id      = var.subnet_id
    availability_zones  = var.default_node_pool.availability_zones
  }

  ## Support RBAC with Active Directory
  dynamic "role_based_access_control" {
    for_each = var.azure_ad.rbac_enabled ? [1] : []

    content {
      azure_active_directory {
        managed                = true
        tenant_id              = data.azurerm_subscription.current.tenant_id
        admin_group_object_ids = [azuread_group.admin.id]
      }

      enabled = true
    }
  }

  ## Only support Kubernetes RBAC
  dynamic "role_based_access_control" {
    for_each = !var.azure_ad.rbac_enabled ? [1] : []

    content {
      enabled = true
    }
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = local.common_tags

  lifecycle {
    ignore_changes = [
      windows_profile,
      default_node_pool
    ]
  }
}

resource "azuread_group" "admin" {
  name        = "aks-${var.name}-admin"
  description = "cluster ${var.name} admins"
  members     = var.azure_ad.admins_object_ids
}