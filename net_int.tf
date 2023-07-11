
# resource "azurerm_network_interface" "public" {
#   name                = "public-nic"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   ip_configuration {
#     name                          = "public"
#     subnet_id                     = azurerm_subnet.public.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id = azurerm_public_ip.public.id
#   }
# }

# resource "azurerm_public_ip" "public" {
#   name                = "vm_public_ip"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   allocation_method   = "Dynamic"
# }


# resource "azurerm_network_interface" "private" {
#   name                = "private-nic"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   ip_configuration {
#     name                          = "private"
#     subnet_id                     = azurerm_subnet.private.id
#     private_ip_address_allocation = "Static"
#     private_ip_address            = "10.0.3.10"
#   }
# }

resource "azurerm_network_interface" "example" {
  name                = "nic-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "ipconfig-example"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Dynamic"
  }
}

///
resource "azurerm_public_ip" "nat_gateway_public_ip" {
  name                = "nat-gateway-public-ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
}

resource "azurerm_subnet" "nat_gateway_subnet" {
  name                 = "nat-gateway-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_nat_gateway" "example" {
  name                = "nat-gateway"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
#   public_ip_address_id = [azurerm_public_ip.nat_gateway_public_ip.id]
#   subnet_id           = [azurerm_subnet.nat_gateway_subnet.id]
}

resource "azurerm_route_table" "private_subnet_route_table" {
  name                = "private-subnet-route-table"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  route {
    name                   = "nat-gateway-route"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.2.0"
  }
}

resource "azurerm_subnet_route_table_association" "private_subnet_association" {
  subnet_id      = azurerm_subnet.private.id
  route_table_id = azurerm_route_table.private_subnet_route_table.id
}

