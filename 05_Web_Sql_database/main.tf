provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.azurerm_resource_group_name
  location = var.azurerm_resource_group_location

  tags = {
    "environment" = "production"
  }
}

resource "azurerm_service_plan" "app_plan" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = var.app_service_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.app_plan.location
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    always_on = false
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:azurerm_mssql_server.sql_server.fully_qualified_domain_name;Database=azurerm_mssql_database.sql_db.name;User Id=azurerm_mssql_server.sql_server.administrator_login;Password=azurerm_mssql_server.sql_server.administrator_login_password;"
  }
}

resource "azurerm_storage_account" "stg_account" {
  name                     = var.azurerm_storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.azurerm_mssql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.azurerm_mssql_server_admin_login
  administrator_login_password = var.azurerm_mssql_server_admin_login_pass
}

resource "azurerm_mssql_database" "sql_db" {
  name           = var.azurerm_mssql_database_name
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 1
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false

  tags = {
    foo = "bar"
  }
}
