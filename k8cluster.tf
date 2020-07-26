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

# analytics creation
resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}

resource "azurerm_log_analytics_workspace" "k8s_ws" {
    # The WorkSpace name has to be unique across the whole of azure
    name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
    location            = var.log_analytics_workspace_location
    resource_group_name = azurerm_resource_group.k8s_rg.name
    sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "k8s_as" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.k8s_ws.location
    resource_group_name   = azurerm_resource_group.k8s_rg.name
    workspace_resource_id = azurerm_log_analytics_workspace.k8s_ws.id
    workspace_name        = azurerm_log_analytics_workspace.k8s_ws.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}


# cluster creation
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "k8s_cluster"
  location            = azurerm_resource_group.k8s_rg.location
  resource_group_name = azurerm_resource_group.k8s_rg.name
  dns_prefix          = var.dns_prefix

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

  # Enable monitoring agent
  addon_profile {
        oms_agent {
        enabled                    = true
        log_analytics_workspace_id = azurerm_log_analytics_workspace.k8s_ws.id
        }
    }

  # Add tags: project, author
  tags = {
    author = var.author
    project = var.project
  }
}
