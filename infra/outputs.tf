output "static_website_url" {
  value = azurerm_storage_account.frontend_storage.primary_web_endpoint
}
