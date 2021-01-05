resource "azurerm_resource_group" "cluster_rg" {
  name     = "rg-${var.environment}-cluster-${var.name}"
  location = var.az_location

  tags = local.common_tags
}