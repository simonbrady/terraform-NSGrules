variable "resource_group_name" {
  description = "resource group name for NSG"
}

# Priority attribute is given as the map key
variable "network_security_rules" {
  type = map(object({
    name                         = string,
    description                  = optional(string),
    direction                    = string,
    access                       = string,
    protocol                     = string,
    source_port_range            = optional(string),
    source_port_ranges           = optional(list(string)),
    destination_port_range       = optional(string),
    destination_port_ranges      = optional(list(string)),
    source_address_prefix        = optional(string),
    source_address_prefixes      = optional(list(string)),
    destination_address_prefix   = optional(string),
    destination_address_prefixes = optional(list(string)),
  }))
  description = "network security rules"
}
