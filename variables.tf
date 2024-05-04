variable "resource_group" {
  description = "The resource group iin which the VNet, ASE, and App Service will be created."
  type = map(string)
  default = {
    "name"     = "app-service-environment-rg"
    "location" = "westus2"
  }
}

variable "vnet" {
  description = "The Virtual network configuration."
  type = map(string)
  default = {
    "name" = "main"
    "cidr" = "10.0.0.0/16"
  }
}

variable "private_subnets" {
  description = "The private subnets for the App Service Environment."
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]

}

variable "ase" {
  description = "The App Service Environment configuration."
  type = map(string)
  default = {
    "name" = "demo-ase"
  }
}

variable "asp" {
  description = "The App Service Plan configuration."
  type = map(string)
  default = {
    "name" = "demo-asp"
    "os" = "Windows"
    "sku" = "I1v2"
  }
}
variable "web_app" {
  type = map(string)
  default = {
    "name" = "web-app"
  }
}
