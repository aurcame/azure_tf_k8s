# Kubernetes cluster creation
#

# Resource group for kube cluster
resource "azurerm_resource_group" "k8s_rg" {
  name     = var.rg_k8s
  location = var.az_region

  # Add tags: project, author
  tags = {
    author = var.author
    project = var.project
  }
}

# cluster creation
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "k8s_cluster"
  location            = azurerm_resource_group.k8s_rg.location
  resource_group_name = azurerm_resource_group.k8s_rg.name
  dns_prefix          = "evn"

  default_node_pool {
    name            = "default"
    vm_size         = "Standard_A2_v2"
    node_count      = 2
  }

  # secrets (use terraform.tfvars file)
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  # Add tags: project, author
  tags = {
    author = var.author
    project = var.project
  }
}
