# Kubernetes cluster creation
#

# Resource group for kube
resource "azurerm_resource_group" "k8s_rg" {
  name     = "k8s_RG1"
  location = var.azure_region
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

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    environment = var.environment
    owner = var.owner
  }
}

#output "client_certificate" {
#  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate}"
#}
#
#output "kube_config" {
#  value = "${azurerm_kubernetes_cluster.k8s.kube_config_raw}"
#}

