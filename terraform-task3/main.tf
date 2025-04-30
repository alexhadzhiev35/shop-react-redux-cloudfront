terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "products_rg" {
  name     = "rg-products-api"
  location = "northeurope"
}

resource "azurerm_storage_account" "products_storage" {
  name                     = "stgproductsalex001"
  resource_group_name      = azurerm_resource_group.products_rg.name
  location                 = azurerm_resource_group.products_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_app_service_plan" "products_plan" {
  name                = "plan-products-api"
  location            = azurerm_resource_group.products_rg.location
  resource_group_name = azurerm_resource_group.products_rg.name
  kind                = "FunctionApp"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "products_function" {
  name                       = "fa-products-service-sand-ne-001"
  location                   = azurerm_resource_group.products_rg.location
  resource_group_name        = azurerm_resource_group.products_rg.name
  app_service_plan_id        = azurerm_app_service_plan.products_plan.id
  storage_account_name       = azurerm_storage_account.products_storage.name
  storage_account_access_key = azurerm_storage_account.products_storage.primary_access_key
  os_type                    = "linux"
  version                    = "~4"

  site_config {
    linux_fx_version = "NODE|18"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
