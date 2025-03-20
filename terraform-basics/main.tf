# Definición del provider que ocuparemos
provider "azurerm" {
  features {}
  subscription_id = "45a3b388-a2a0-4663-816a-2fdea4b26e9a"
}

# Se crea el grupo de recursos, al cual se asociarán los demás recursos
resource "azurerm_resource_group" "rg" {
  name     = var.name_function
  location = var.location
}

# Se crea un Storage Account, para asociarlo al function app (recomendación de la documentación).
resource "azurerm_storage_account" "sa" {
  name                     = var.name_function
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Se crea el recurso Service Plan para especificar el nivel de servicio 
# (por ejemplo, "Consumo", "Functions Premium" o "Plan de App Service"), en este caso "Y1" hace referencia a plan consumo 
resource "azurerm_service_plan" "sp" {
  name                = var.name_function
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Windows"
  sku_name            = "Y1"
}

# Se crea la aplicación de Funciones 
resource "azurerm_windows_function_app" "wfa" {
  name                = var.name_function
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  service_plan_id            = azurerm_service_plan.sp.id

  site_config {
    application_stack {
      node_version = "~18"
    }
  }
}

# Se crea una función dentro de la aplicación de funciones
resource "azurerm_function_app_function" "faf" {
  name            = var.name_function
  function_app_id = azurerm_windows_function_app.wfa.id
  language        = "Javascript"
  # Se carga el código de ejemplo dentro de la función
  file {
    name    = "index.js"
    content = file("example/index.js")
  }
  # Se define el payload para los test
  test_data = jsonencode({
    "name" = "Azure"
  })
  # Se mapean las solicitudes
  config_json = jsonencode({
    "bindings" : [
      {
        "authLevel" : "anonymous",
        "type" : "httpTrigger",
        "direction" : "in",
        "name" : "req",
        "methods" : [
          "get",
          "post"
        ]
      },
      {
        "type" : "http",
        "direction" : "out",
        "name" : "res"
      }
    ]
  })
}


