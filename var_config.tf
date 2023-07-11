variable "vnet_name" {
  default = "proj-vent"
}

variable "resource_group_name" {
  default = "proj_homework"
}

variable "public_subnet_name" {
  default = "PublicSubnet"
}

variable "private_subnet_name" {
  default = "PrivateSubnet"
}

variable "public_vm_name" {
  default = "PublicVM"
}

variable "private_vm_name" {
  default = "PrivateVM"
}

variable "nat_gateway_name" {
  default = "NATGateway"
}

variable "private_route_table_name" {
  default = "PrivateRouteTable"
}

# ที่อยู่ IP NAT Gateway
variable "nat_gateway_ip" {
  default = "X.X.X.X"
}

variable "load_balancer_name" {
  default = "load-balancer"
}

variable "vm_name" {
  default = "tfproj"
}