terraform {
  backend "azurerm" {
    resource_group_name  = "rsg-tfstate"
    storage_account_name = "tfstate28122022"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
