provider "azurerm" {
  features {}
}

module "aks-cluster" {
  source = "../../../terraform-azure-k8s-clusters"

  client_id             = var.client_id
  client_secret         = var.client_secret
  name                  = var.name
  subnet_id             = var.subnet_id
  additional_node_pools = var.additional_node_pools
}
