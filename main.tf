provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "clusters_rg" {
  for_each = var.clusters

  name     = "rg-${var.environment}-cluster-${each.key}"
  location = var.az_location

  tags = local.common_tags
}