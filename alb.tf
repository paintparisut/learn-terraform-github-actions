# Create Azure Load Balancer
resource "azurerm_lb" "example" {
  name                = var.load_balancer_name
  location            = "southeastasia"
  resource_group_name = azurerm_resource_group.example.name

  sku = "Standard"

  frontend_ip_configuration {
    name                          = "public-ip"
    subnet_id                     = azurerm_subnet.public.id
    # public_ip_address_allocation = "Static"
  }
}

# Create Azure Load Balancer rule for SSH traffic
resource "azurerm_lb_rule" "ssh" {
  name                   = "ssh-rule"
#   resource_group_name = azurerm_resource_group.example.name
  loadbalancer_id        = azurerm_lb.example.id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.example.id]
  protocol               = "Tcp"
  frontend_port          = 22
  backend_port           = 22
  frontend_ip_configuration_name = azurerm_lb.example.frontend_ip_configuration[0].name
}

resource "azurerm_lb_backend_address_pool" "example" {
  name                = "backend-pool"
  loadbalancer_id     = azurerm_lb.example.id
}


# # Create Azure Load Balancer outbound rule
# resource "azurerm_lb_outbound_rule" "example" {
#   name                   = "outbound-rule"
#   loadbalancer_id        = azurerm_lb.example.id
#   backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
#   protocol               = "All"
#   idle_timeout_in_minutes = 30
#   allocated_outbound_ports = 1000
# }