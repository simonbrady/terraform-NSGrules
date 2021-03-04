
variable "resource_group_name" {
  description = "resource group name for vnet"
}


variable "network_security_rules" {
  type        = map(object({
    name                         = string,
    description                  = string,
    priority                     = number,
    direction                    = string,
    access                       = string,
    protocol                     = string,
    source_port_range            = string,
    source_port_ranges           = list(any),
    destination_port_range       = string,
    destination_port_ranges      = list(any),
    source_address_prefix        = string,
    source_address_prefixes      = list(any),
    destination_address_prefix   = string,
    destination_address_prefixes = list(any),
  }))
  description = "network security rules"

}