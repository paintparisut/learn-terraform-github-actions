# # private VM
# resource "azurerm_virtual_machine" "private" {
#   name                  = var.private_vm_name
#   resource_group_name   = azurerm_resource_group.example.name
#   location              = azurerm_resource_group.example.location
#   vm_size               = "Standard_DS1_v2"
#   network_interface_ids = [azurerm_network_interface.private.id]

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "16.04-LTS"
#     version   = "latest"
#   }

#   storage_os_disk {
#     name              = "${var.private_vm_name}-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   os_profile {
#     computer_name  = var.private_vm_name
#     admin_username = "adminuser"
#     admin_password = "P@ssw0rd1234"
#   }

#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }