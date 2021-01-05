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

  default = "single-cluster"
}

variable "subnet_id" {
  description = "The subnet id where the AKS cluster should be attached to"
  type        = string

  default = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-dev-k8s-infra/providers/Microsoft.Network/virtualNetworks/vnet-dev-k8s-infra/subnets/snet-dev-bastion"
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

  default = {
    "pool1" = {
      subnet_id            = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-dev-k8s-infra/providers/Microsoft.Network/virtualNetworks/vnet-dev-k8s-infra/subnets/snet-dev-bastion"
      node_count           = 2
      vm_size              = "Standard_DS2_v2"
      os_type              = "Linux"
      os_disk_size_gb      = 30
      auto_scaling_enabled = true
      min_count            = 2
      max_count            = 4
      availability_zones   = ["1"]
    }
  }
}