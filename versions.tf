terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.101.0"
    }
  }
  required_version = "1.8.2"
}

provider "azurerm" {
  features {
    
  }
}