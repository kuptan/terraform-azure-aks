resource "azurerm_key_vault" "key_vault" {
  for_each = var.clusters

  name                        = "kv-${var.environment}-${each.key}"
  resource_group_name         = azurerm_resource_group.clusters_rg[each.key].name
  location                    = azurerm_resource_group.clusters_rg[each.key].location
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_subscription.current.tenant_id

  sku_name = "standard"

  tags = local.common_tags
}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  depends_on = [azurerm_key_vault.key_vault]

  for_each = var.key_vault_policy_object_ids

  key_vault_id = azurerm_key_vault.key_vault[each.value.cluster].id
  object_id    = each.value.id
  tenant_id    = data.azurerm_subscription.current.tenant_id

  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
  storage_permissions     = var.storage_permissions
}

resource "azurerm_key_vault_secret" "k8s_private_key" {
  depends_on = [azurerm_key_vault_access_policy.key_vault_access_policy]

  for_each = var.clusters

  name         = "k8s-private-key"
  value        = tls_private_key.k8s_ssh_key[each.key].private_key_pem
  key_vault_id = azurerm_key_vault.key_vault[each.key].id

  tags = local.common_tags
}

resource "azurerm_key_vault_secret" "k8s_public_key" {
  depends_on = [azurerm_key_vault_access_policy.key_vault_access_policy]

  for_each = var.clusters

  name         = "k8s-public-key"
  value        = tls_private_key.k8s_ssh_key[each.key].public_key_openssh
  key_vault_id = azurerm_key_vault.key_vault[each.key].id

  tags = local.common_tags
}
