
provider "azurerm" {
  features {}

  # You can either hardcode your subscription_id here or rely on Azure CLI authentication
  # Uncomment the next line if you'd like to hardcode the subscription ID
  
}

# Resource Group definition
resource "azurerm_resource_group" "my_rg" {
  name     = "myResourceGroup"
  location = "East US"
}

# App Service Plan definition
resource "azurerm_app_service_plan" "my_plan" {
  name                = "myAppServicePlan"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

# App Service definition
resource "azurerm_app_service" "my_app" {
  name                = "myAppService"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  app_service_plan_id = azurerm_app_service_plan.my_plan.id

  site_config {
    always_on        = true
    linux_fx_version = "NODE|14-lts"  # For Node.js applications
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    WEBSITES_PORT                       = "3000"  # Ensure this port matches the port used by your app
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITES_PORT"],
    ]
  }
}

# Output the default hostname of the app service
output "app_service_default_hostname" {
  value       = azurerm_app_service.my_app.default_site_hostname
  description = "The default hostname for the Azure App Service"
}

