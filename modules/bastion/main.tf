resource "azurerm_resource_group" "bastion_rg" {
  name     = "rg-${var.environment}-bastion"
  location = var.az_location

  tags = var.tags
}

resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "pip-${var.environment}-bastion"
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location
  allocation_method   = "Static"

  tags = var.tags
}

resource "azurerm_network_interface" "bastion_nic" {
  name                = "nic-${var.environment}-bastion"
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location

  ip_configuration {
    name                          = "bastion_nic_ip_config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_public_ip.id
  }
}

resource "azurerm_virtual_machine" "bastion" {
  name                  = "vm-${var.environment}-bastion"
  resource_group_name   = azurerm_resource_group.bastion_rg.name
  location              = azurerm_resource_group.bastion_rg.location
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-${var.environment}-bastion"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.name
    admin_username = var.bastion_admin_user
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.bastion_admin_user}/.ssh/authorized_keys"
      key_data = tls_private_key.bastion_ssh_key.public_key_openssh
    }
  }

  tags = var.tags
}

resource "azurerm_network_security_rule" "bastion_nsg_rule" {
  name                        = "ExampleWhiteListIPToBastion"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "192.168.1.24"
  source_port_range           = "*"
  destination_address_prefix  = azurerm_public_ip.bastion_public_ip.ip_address
  destination_port_range      = "22"
  resource_group_name         = local.infra_rg_name
  network_security_group_name = data.azurerm_network_security_group.bastion_nsg.name
}

# This feature is currently on preview, once its in production, uncomment this code
# ref: https://docs.microsoft.com/en-us/azure/active-directory/devices/howto-vm-sign-in-azure-ad-windows

# List all the types and publishers using this command
# command: az vm extension image list --location westus -o table
# resource "azurerm_virtual_machine_extension" "bastion_vm_extension" {
#   name                 = "ad_ssh_login"
#   virtual_machine_id   = azurerm_virtual_machine.bastion.id
#   publisher            = "Microsoft.Azure.ActiveDirectory.LinuxSSH"
#   type                 = "AADLoginForLinux"
#   type_handler_version = "1.0"

#   tags = local.common_tags
# }
