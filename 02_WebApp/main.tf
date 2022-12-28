terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.33.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# resource "azurerm_app_service_plan" "example" {
#   name                = var.app_service_plan_name
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   sku {
#     tier = "Standard"
#     size = "S1"
#   }
# }

resource "azurerm_service_plan" "example" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Linux"
  sku_name            = "F1"
}

# resource "azurerm_app_service" "example" {
#   name                = var.app_service_name
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   app_service_plan_id = azurerm_service_plan.example.id

#   site_config {
#     dotnet_framework_version = "v4.0"
#     scm_type                 = "LocalGit"
#   }

#   app_settings = {
#     "SOME_KEY" = "some-value"
#   }

#   connection_string {
#     name  = "Database"
#     type  = "SQLServer"
#     value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
#   }
# }

resource "azurerm_linux_web_app" "example" {
  name                = var.app_service_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {
    application_stack {
      dotnet_version = "5.0"
    }
    # Mandatory if free tier service plan
    always_on = false
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
