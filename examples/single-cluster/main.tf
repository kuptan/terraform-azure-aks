provider "azurerm" {
  features {}
}

module "aks-cluster" {
  source = "kube-champ/aks/azure"

  client_id     = var.client_id
  client_secret = var.client_secret
  name          = var.name
  subnet_id     = var.subnet_id
}
