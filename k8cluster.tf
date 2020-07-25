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

resource "azurerm_log_analytics_workspace" "K8s_WS" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
    location            = var.log_analytics_workspace_location
    resource_group_name = azurerm_resource_group.K8s_RG.name
    sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "K8s_AS" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.K8s_WS.location
    resource_group_name   = azurerm_resource_group.K8s_RG.name
    workspace_resource_id = azurerm_log_analytics_workspace.K8s_WS.id
    workspace_name        = azurerm_log_analytics_workspace.K8s_WS.name

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
        log_analytics_workspace_id = azurerm_log_analytics_workspace.K8s_WS.id
        }
    }

  # Add tags: project, author
  tags = {
    author = var.author
    project = var.project
  }
}
