locals {
  admin_groups = {
    for key, value in var.clusters :
    key => {
      members = value.ad_admins_object_ids
    }
    if value.ad_rbac_enabled
  }
}

resource "azurerm_kubernetes_cluster" "kube_cluster" {
  for_each = var.clusters

  name                    = "k8s-${var.environment}-${each.key}"
  location                = azurerm_resource_group.clusters_rg[each.key].location
  resource_group_name     = azurerm_resource_group.clusters_rg[each.key].name
  dns_prefix              = each.value.cluster_network.dns_prefix
  kubernetes_version      = each.value.cluster_version
  private_cluster_enabled = each.value.private_cluster_enabled

  addon_profile {
    kube_dashboard {
      enabled = each.value.kube_dashboard_enabled
    }
  }

  linux_profile {
    admin_username = each.value.cluster_admin_user

    ssh_key {
      key_data = tls_private_key.k8s_ssh_key[each.key].public_key_openssh
    }
  }

  network_profile {
    network_plugin     = each.value.cluster_network.network_plugin
    network_policy     = each.value.cluster_network.network_policy
    service_cidr       = each.value.cluster_network.service_cidr
    docker_bridge_cidr = each.value.cluster_network.docker_bridge_cidr
    dns_service_ip     = each.value.cluster_network.dns_service_ip
    load_balancer_sku  = each.value.cluster_network.load_balancer_sku
  }

  default_node_pool {
    name                = each.value.default_node_pool.name
    node_count          = each.value.default_node_pool.node_count
    min_count           = each.value.default_node_pool.min_count
    max_count           = each.value.default_node_pool.max_count
    vm_size             = each.value.default_node_pool.vm_size
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    os_disk_size_gb     = each.value.default_node_pool.os_disk_size_gb
    vnet_subnet_id      = var.subnets["snet-${var.environment}-${each.value.subnet_name}"]
    availability_zones  = each.value.default_node_pool.availability_zones
  }

  ## Support RBAC with Active Directory
  dynamic "role_based_access_control" {
    for_each = each.value.ad_rbac_enabled == true ? [1] : []

    content {
      azure_active_directory {
        managed                = true
        tenant_id              = data.azurerm_subscription.current.tenant_id
        admin_group_object_ids = [azuread_group.admin[each.key].id]
      }

      enabled = true
    }
  }

  ## Only support Kubernetes RBAC
  dynamic "role_based_access_control" {
    for_each = each.value.ad_rbac_enabled == false ? [1] : []

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
  for_each = local.admin_groups

  name        = "aks-${each.key}-admin"
  description = "cluster ${each.key} admin"
  members     = each.value.members
}