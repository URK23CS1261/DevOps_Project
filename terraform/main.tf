provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "azurerm_resource_group" "athena_rg" {
  name     = "athena-rg"
  location = "Central India"
}