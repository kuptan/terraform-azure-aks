## Required Variables

variable "client_id" {
  description = "Service principal's client ID for AKS service principal configuration"
  type = string
}

variable "client_secret" {
  description = "Service principal's client secret for AKS service principal configuration"
  type = string
}

variable "key_vault_policy_object_ids" {
  description = "The object ids associated with the key vault policy"
  type        = map(object({ id : string, name : string, cluster : string }))
}

variable "infra_name" {
  description = "A general name that will be used on the resources"
  type        = string
}

## Optional Variables
variable "environment" {
  description = "The environment name (dev, staging, prod, etc...)"
  type = string

  default = "dev"
}

variable "az_location" {
  description = "The azure location on which resources are deployed"
  type = string

  default = "north europe"
}

variable "subnets" {
  description = "The subnets names"
  type = map(string)

  default = {}
}

variable "clusters" {
  description = "The clusters configurations"
  type = map(object({
    cluster_name : string
    subnet_name : string
    cluster_version : string
    kube_dashboard_enabled : bool
    private_cluster_enabled : bool
    cluster_admin_user : string
    cluster_network : object({
      network_plugin : string
      network_policy : string
      service_cidr : string
      docker_bridge_cidr : string
      dns_service_ip : string
      dns_prefix : string
      load_balancer_sku : string
    }),
    default_node_pool = object({
      name : string
      node_count : number
      vm_size : string
      os_disk_size_gb : number
      min_count : number
      max_count : number
      availability_zones : list(number)
    })
    ad_rbac_enabled : bool
    ad_admins_object_ids : list(string)
  }))
}

variable "additional_node_pools" {
  description = "Additional pools config to AKS clusters"
  type = map(object({
    name : string
    cluster_name : string
    subnet_name : string
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

variable "bastion_enabled" {
  description = "Flag whether a bastion instance should be created"
  type = bool

  default = false
}

variable "bastion_admin_user" {
  description = "Bastion admin username in case 'bastion_enabled' flag is set to true"
  type = string

  default = "kubebastionadmin"
}

variable "key_permissions" {
  description = "Key vault key permissions"
  type = list(string)

  default = [
    "create",
    "get",
    "list",
    "delete"
  ]
}

variable "secret_permissions" {
  description = "Key vault secret permissions"
  type = list(string)

  default = [
    "list",
    "get",
    "set",
    "delete",
  ]
}

variable "certificate_permissions" {
  description = "Key vault certificate permissions"
  type = list(string)

  default = [
    "list",
    "delete",
    "get",
    "create",
    "update",
  ]
}

variable "storage_permissions" {
  description = "Key vault storage permissions"
  type = list(string)

  default = [
    "get",
    "list",
    "delete",
    "update",
  ]
}

variable "tags" {
  description = "Additional tags"
  type = map(string)

  default = {}
}
