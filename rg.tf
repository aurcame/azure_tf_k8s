# Resource group definition
#

resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.azure_region

  tags = {
    environment = var.environment
    owner = var.owner
  }
}

