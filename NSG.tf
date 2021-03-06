# The optional attributes experiment is only available from TF 0.14, see
# https://www.terraform.io/docs/language/expressions/type-constraints.html#experimental-optional-object-type-attributes

terraform {
  required_version = ">= 0.14"
  experiments      = [module_variable_optional_attrs]
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2"
    }
  }
}

provider "azurerm" {
  features {}
}

##
#  NSGs + Rules
##

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "Australia East"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "testnsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "nsgrule" {
  for_each                     = var.network_security_rules
  name                         = each.value.name
  description                  = each.value.description
  priority                     = each.key
  direction                    = each.value.direction
  access                       = each.value.access
  protocol                     = each.value.protocol
  source_port_range            = each.value.source_port_range
  source_port_ranges           = each.value.source_port_ranges
  destination_port_range       = each.value.destination_port_range
  destination_port_ranges      = each.value.destination_port_ranges
  source_address_prefix        = each.value.source_address_prefix
  source_address_prefixes      = each.value.source_address_prefixes
  destination_address_prefix   = each.value.destination_address_prefix
  destination_address_prefixes = each.value.destination_address_prefixes
  resource_group_name          = azurerm_resource_group.rg.name
  network_security_group_name  = azurerm_network_security_group.nsg.name
}
