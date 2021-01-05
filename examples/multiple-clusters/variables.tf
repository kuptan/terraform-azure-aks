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

variable "clusters" {
  type = map(map(string))

  default = {
    "cluster-a" = {
      subnet_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-dev-k8s-infra/providers/Microsoft.Network/virtualNetworks/vnet-dev-k8s-infra/subnets/snet-dev-bastion"
    }
    "cluster-b" = {
      subnet_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-dev-k8s-infra/providers/Microsoft.Network/virtualNetworks/vnet-dev-k8s-infra/subnets/snet-dev-bastion"
    }
  }
}