output "mysql_db_name" {
  value = azurerm_mssql_database.sql_db.name
}

output "mysql_db_id" {
  value = azurerm_mssql_database.sql_db.id
}

output "web_app_url" {
  value = azurerm_linux_web_app.webapp.default_hostname
}

output "web_app_ips" {
  value = azurerm_linux_web_app.webapp.outbound_ip_addresses
}
