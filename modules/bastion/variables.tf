variable "tenant_id" {
  type = string
}

variable "az_location" {
  type = string
}

variable "infra_name" {
  type        = string
}

variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_vault_policy_object_ids" {
  type        = map(object({ id: string, name: string, cluster: string }))
  description = "The object ids associated with the key vault policy"
}

variable "key_permissions" {
  type = list(string)
  default = []
}

variable "secret_permissions" {
  type = list(string)
  default = []
}

variable "certificate_permissions" {
  type = list(string)
  default = []
}

variable "storage_permissions" {
  type = list(string)
  default = []
}

variable "tags" {
  type = map(string)

  default = {}
}

variable "bastion_admin_user" {
  default = "kubebastionadmin"
}
