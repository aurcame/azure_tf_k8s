# Global variables for infrastructure definitiion
#

# Azure provider settings
variable "subscription_id"{}
variable "client_id"{}
variable "client_secret"{}
variable "tenant_id"{}

# Default region
variable "azure_region" {
  default = "West Europe"
}

# Resource group
variable "rgname" {
  default = "K8s_RG"
}

# Environment name
variable "environment" {
  default =   "LAB"
}

# Author name
variable "owner" {
  default =   "EvgeniyNaryshkin.aurcame"
}
