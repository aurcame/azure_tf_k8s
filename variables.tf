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

# Describe tags
# Author name tag
variable "author" {
  default =   "Evgeniy_Naryshkin.aurcame"
}

# Project tag
variable "project" {
  default =   "LAB_TF_AZ_K8s"
}
