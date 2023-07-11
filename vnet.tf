resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

#public subnet
resource "azurerm_subnet" "public" {
  name                 = "PublicSubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

#private subnet
resource "azurerm_subnet" "private" {
  name                 = "PrivateSubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_security_group" "example" {
  name                = "ssh_nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "allow_ssh_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
    security_rule {
    name                       = "allow_web_sh"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# # Azure NAT Gateway
# resource "azurerm_nat_gateway" "example" {
#   name                = var.nat_gateway_name
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   public_subnet_id    = azurerm_subnet.public.id
#   allocation_method   = "Static"

#   sku {
#     name     = "Standard"
#     tier     = "Standard"
#     capacity = 2
#   }
# }

# Azure Route Table for public subnet
resource "azurerm_route_table" "public" {
  name                = "PublicRouteTable"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  route {
    name                   = "InternetRoute"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  }
}

#association for public subnet / route table
resource "azurerm_subnet_route_table_association" "public" {
  subnet_id      = azurerm_subnet.public.id
  route_table_id = azurerm_route_table.public.id
}

#Azure Route Table for private subnet
resource "azurerm_route_table" "private" {
  name                = "PrivateRouteTable"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  route {
    name                   = "NatRoute"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.3.0"
  }
}

# #association for private subnet / route table
# resource "azurerm_subnet_route_table_association" "private" {
#   subnet_id      = azurerm_subnet.private.id
#   route_table_id = azurerm_route_table.private.id
# }


# Associate private subnet with NAT Gateway
# resource "azurerm_subnet_nat_gateway_association" "example" {
#   subnet_id           = azurerm_subnet.private.id
#   nat_gateway_id      = azurerm_nat_gateway.example.id
#   resource_group_name = var.resource_group_name
# }

# Configure NSG for private subnet
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.example.id
}
