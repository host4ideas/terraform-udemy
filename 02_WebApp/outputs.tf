output "web_app_url" {
  value = azurerm_linux_web_app.example.default_hostname
}

output "web_app_ip" {
  value = azurerm_linux_web_app.example.outbound_ip_addresses
}
