variable "azurerm_resource_group_name" {
  type        = string
  description = "RSG name"
}

variable "azurerm_resource_group_location" {
  type        = string
  description = "RSG location"
}

variable "app_service_plan_name" {
  type        = string
  description = "App Service Plan name in Azure"
}

variable "app_service_name" {
  type        = string
  description = "App Service name in Azure"
}

variable "azurerm_storage_account_name" {
  type        = string
  description = "RSG Account name"
}

variable "azurerm_mssql_server_name" {
  type        = string
  description = "MYSQL Server name"
}

variable "azurerm_mssql_server_admin_login" {
  type        = string
  description = "MYSQL Server admin login user"
}

variable "azurerm_mssql_server_admin_login_pass" {
  type        = string
  description = "MYSQL Server admin login password"
}

variable "azurerm_mssql_database_name" {
  type        = string
  description = "MYSQL DB name"
}
