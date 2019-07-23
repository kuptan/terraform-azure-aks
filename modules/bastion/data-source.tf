data "azurerm_network_security_group" "bastion_nsg" {
  name                = "nsg-${var.environment}-bastion"
  resource_group_name = local.infra_rg_name
}
