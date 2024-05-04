
resource "random_pet" "prefix" {

}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group["name"]
  location = var.resource_group["location"]

}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.vnet.cidr]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet${count.index + 1}"
  resource_group_name  = azurerm_resource_group.rg.name
  count                = 2
  address_prefixes     = [var.private_subnets[count.index]]
  virtual_network_name = azurerm_virtual_network.vnet.name

  delegation {
    name = "Microsoft.Web.hostingEnvironments"
    service_delegation {
      name    = "Microsoft.Web/hostingEnvironments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_app_service_environment_v3" "ase" {
  name                         = "${random_pet.prefix.id}-${var.ase.name}"
  resource_group_name          = azurerm_resource_group.rg.name
  subnet_id                    = azurerm_subnet.subnet[0].id
  internal_load_balancing_mode = "Web, Publishing"
}

resource "azurerm_service_plan" "asp" {
  name                       = var.asp.name
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  app_service_environment_id = azurerm_app_service_environment_v3.ase.id
  os_type                    = var.asp.os
  sku_name                   = var.asp.sku
}

resource "azurerm_windows_web_app" "web_app" {
  name                =  var.web_app.name
  resource_group_name =  azurerm_resource_group.rg.name
  location            =  azurerm_resource_group.rg.location
  service_plan_id     =  azurerm_service_plan.asp.id
  site_config {}

}

resource "azurerm_windows_web_app_slot" "stage" {
  name           = "stage"
  app_service_id = azurerm_windows_web_app.web_app.id
  site_config {}
}

resource "azurerm_windows_web_app_slot" "prod" {
  name           = "prod"
  app_service_id = azurerm_windows_web_app.web_app.id

  site_config {}
}


resource "azurerm_web_app_active_slot" "active_slot" {
  slot_id = azurerm_windows_web_app_slot.stage.id
}




