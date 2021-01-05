provider "azurerm" {
  features {}
}

module "aks-cluster" {
  for_each = var.clusters

  source = "../../../terraform-azure-k8s-clusters"

  client_id     = var.client_id
  client_secret = var.client_secret

  name      = each.key
  subnet_id = each.value.subnet_id
}
