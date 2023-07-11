# # public VM
# resource "azurerm_virtual_machine" "public" {
#   name                  = var.public_vm_name
#   resource_group_name   = azurerm_resource_group.example.name
#   location              = azurerm_resource_group.example.location
#   vm_size               = "Standard_DS1_v2"
#   network_interface_ids = [azurerm_network_interface.public.id]

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "16.04-LTS"
#     version   = "latest"
#   }

#   storage_os_disk {
#     name              = "${var.public_vm_name}-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   os_profile {
#     computer_name  = var.public_vm_name
#     admin_username = "adminuser"
#     admin_password = "P@ssw0rd1234"
#   }

#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }

resource "azurerm_virtual_machine" "example" {
  name                  = var.vm_name
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = "Standard_DS2_v2"

  os_profile {
    computer_name  = var.vm_name
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
    storage_os_disk {
    name              = "${var.public_vm_name}-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
   os_profile_linux_config {
    disable_password_authentication = false
  }
}
