terraform {
  required_version = "~> 1.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  subscription_id = "d0f6eb41-3e86-48da-bc57-893eab20796f" # AZ-DJY-Bootstrap
  features {}
}

data "azurerm_client_config" "this" {}
