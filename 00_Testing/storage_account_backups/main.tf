provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "rsg" {
  name     = var.rsg_name
  location = var.rsg_location
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.sg_account_name
  resource_group_name      = azurerm_resource_group.rsg.name
  location                 = azurerm_resource_group.rsg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "state_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}
