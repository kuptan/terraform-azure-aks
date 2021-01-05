variable "client_id" {
  description = "Service principal's client ID for AKS service principal configuration"
  sensitive = true
  type = string
}

variable "client_secret" {
  description = "Service principal's client secret for AKS service principal configuration"
  sensitive = true
  type = string
}

variable "name" {
  description = "The cluster name"
  type = string

  default = "single-cluster"
}

variable "subnet_id" {
  description = "The subnet id where the AKS cluster should be attached to"
  type = string

  default = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-dev-k8s-infra/providers/Microsoft.Network/virtualNetworks/vnet-dev-k8s-infra/subnets/snet-dev-bastion"
}