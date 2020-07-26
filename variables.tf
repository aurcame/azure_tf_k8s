# Global variables for infrastructure definitiion
#

# Azure provider settings
variable "subscription_id"{}
variable "client_id"{}
variable "client_secret"{}
variable "tenant_id"{}

# Default region
variable "az_region" {
  default = "West Europe"
}

# Resource group
variable "rg_name" {
  default = "az_RG"
}

# Resource group for kubernetes cluster
variable "rg_k8s" {
  default = "K8s_RG"
}

# Dns prefix for kubernetes cluster
variable "dns_prefix" {
  default = "evn"
}

variable log_analytics_workspace_name {
    default = "K8sLogAnalyticsWorkspaceName"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "eastus"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}

# Describe tags
# Author name tag
variable "author" {
  default =   "Evgeniy_Naryshkin.aurcame"
}

# Project tag
variable "project" {
  default =   "LAB_TF_AZ_K8s"
}
