resource "azurerm_key_vault" "key_vault_bastion" {
  name                        = "kv-bastion-${var.environment}"
  resource_group_name         = azurerm_resource_group.bastion_rg.name
  location                    = azurerm_resource_group.bastion_rg.location
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id

  sku_name = "standard"

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  depends_on = [azurerm_key_vault.key_vault_bastion]

  for_each = var.key_vault_policy_object_ids

  key_vault_id = azurerm_key_vault.key_vault_bastion.id
  object_id    = each.value.id
  tenant_id    = var.tenant_id

  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
  storage_permissions     = var.storage_permissions
}

resource "azurerm_key_vault_secret" "bastion_private_key" {
  depends_on = [azurerm_key_vault_access_policy.key_vault_access_policy]

  name         = "bastion-private-key"
  value        = tls_private_key.bastion_ssh_key.private_key_pem
  key_vault_id = azurerm_key_vault.key_vault_bastion.id

  tags = var.tags
}

resource "azurerm_key_vault_secret" "bastion_public_key" {
  depends_on = [azurerm_key_vault_access_policy.key_vault_access_policy]

  name         = "bastion-public-key"
  value        = tls_private_key.bastion_ssh_key.public_key_openssh
  key_vault_id = azurerm_key_vault.key_vault_bastion.id

  tags = var.tags
}
