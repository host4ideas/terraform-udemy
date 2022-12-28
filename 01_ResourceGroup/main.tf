# Azure resource manager
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.33.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "myFirstResourceGroup2"
  location = "westeurope"
}
