provider "azurerm" {
  features {}
  subscription_id = "6f87b73d-c728-4ea5-b4d7-dbe3deafac28"

}

resource "azurerm_resource_group" "frontend_rg" {
  name     = "rg-learnazure-ne-001"
  location = "northeurope"
}

resource "azurerm_storage_account" "frontend_storage" {
  name                     = "stglearnfazure0001"
  resource_group_name      = azurerm_resource_group.frontend_rg.name
  location                 = azurerm_resource_group.frontend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }
}
