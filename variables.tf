## Required Variables

variable "client_id" {
  description = "Service principal's client ID for AKS service principal configuration"
  sensitive   = true
  type        = string
}

variable "client_secret" {
  description = "Service principal's client secret for AKS service principal configuration"
  sensitive   = true
  type        = string
}

variable "name" {
  description = "The cluster name"
  type        = string
}

variable "subnet_id" {
  description = "The subnet id where the AKS cluster should be attached to"
  type        = string
}

variable "environment" {
  description = "The environment name (dev, staging, prod, etc...)"
  type        = string

  default = "dev"
}

variable "az_location" {
  description = "The azure location on which resources are deployed"
  type        = string

  default = "westeurope"
}

variable "cluster_version" {
  description = "The kubernetes version"
  type        = string

  default = "1.18.10"
}

variable "cluster_network" {
  description = "Advanced networking configuration for AKS"
  type = object({
    network_plugin : string
    network_policy : string
    service_cidr : string
    docker_bridge_cidr : string
    dns_service_ip : string
    load_balancer_sku : string
  })

  default = {
    network_plugin     = "azure"
    network_policy     = "calico"
    service_cidr       = "10.100.0.0/16"
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip     = "10.100.0.10"
    load_balancer_sku  = "Standard"
  }
}

variable "default_node_pool" {
  description = "The default node pool configuration"
  type = object({
    name : string
    node_count : number
    vm_size : string
    os_disk_size_gb : number
    type : string
    enable_auto_scaling : bool
    min_count : number
    max_count : number
    availability_zones : list(number)
  })

  default = {
    name                = "d4v3"
    node_count          = 2
    vm_size             = "Standard_D4_v3"
    os_disk_size_gb     = 30
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 4
    availability_zones  = ["1"]
  }
}

variable "kube_dashboard_enabled" {
  description = "A flag to enable/disable kubernetes dashboard"
  type        = bool

  default = false
}

variable "private_cluster_enabled" {
  description = "A flag to enable/disable private clusters"
  type        = bool

  default = false
}

variable "azure_ad" {
  description = "Azure AD integration config"
  type        = object({ rbac_enabled : bool, admins_object_ids : list(string) })

  default = {
    rbac_enabled      = false
    admins_object_ids = []
  }
}


variable "additional_node_pools" {
  description = "Additional node pools configuration"
  type = map(object({
    subnet_id : string
    node_count : number
    vm_size : string
    os_type : string
    os_disk_size_gb : number
    auto_scaling_enabled : bool
    min_count : number
    max_count : number
    availability_zones : list(number)
  }))

  default = {}
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)

  default = {}
}
