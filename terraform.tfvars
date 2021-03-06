resource_group_name = "testrg"
network_security_rules = {
  100 = {
    name                       = "allow-rdp-inbound"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 3389
    source_address_prefixes    = ["192.168.0.0/24", "192.168.10.0/24"]
    destination_address_prefix = "*"
  }
  110 = {
    name                       = "allow-http-inbound"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = [80, 443]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
}
