# VPC and Subnets
#

# Virtual network
resource "azurerm_virtual_network" "Vnet" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  
  # make 3 subnets inside VPC
  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
  }

  # Include Resource group 
  depends_on = [ azurerm_resource_group.rg ]
 
  # Add tags: project, author 
  tags = {
    author = var.author
    project = var.project
  }
}
