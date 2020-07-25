# Resource group definition
#

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.az_region

  # Add tags: project, author
  tags = {
    author = var.author
    project = var.project
  }
}

