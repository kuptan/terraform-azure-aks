# module "bastion" {
#   source = "./modules/bastion"
#   count  = var.bastion_enabled ? 1 : 0

#   az_location                 = var.az_location
#   infra_name                  = var.infra_name
#   name                        = "k8s-bastion"
#   tenant_id                   = data.azurerm_subscription.current.tenant_id
#   key_vault_policy_object_ids = var.key_vault_policy_object_ids
#   key_permissions             = var.key_permissions
#   secret_permissions          = var.secret_permissions
#   certificate_permissions     = var.certificate_permissions
#   storage_permissions         = var.storage_permissions
#   environment                 = var.environment
#   subnet_id                   = var.subnets["snet-${var.environment}-bastion"]
#   bastion_admin_user          = var.bastion_admin_user
#   tags                        = local.common_tags
# }
