terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {

  }
}

provider "azapi" {

}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = var.webapp_name
    Team        = var.resource_group_team
  }
}

resource "azapi_resource" "environment" {
  type      = "Microsoft.App/managedEnvironments@2026-01-01"
  parent_id = azurerm_resource_group.rg.id
  name      = var.webapp_env
  location  = azurerm_resource_group.rg.location
  body = {
    properties = {}
  }
}

resource "azapi_resource" "app" {
  type      = "Microsoft.App/containerApps@2026-01-01"
  parent_id = azurerm_resource_group.rg.id
  name      = var.webapp_name
  location  = azurerm_resource_group.rg.location
  body = {
    properties : {
      environmentId = azapi_resource.environment.id
      configuration = {
        ingress = {
          external   = true # public HTTPS endpoint
          targetPort = 80
          transport  = "auto"
        }
      }
      template = {
        containers = [
          {
            name  = "main"
            image = "mcr.microsoft.com/k8se/quickstart:latest"
            resources = {
              cpu    = 0.25
              memory = "0.5Gi"
            }
          }
        ]
        scale = {
          minReplicas = 0 # scale to zero when there's no traffic
          maxReplicas = 1
        }
      }
    }
  }
  response_export_values = ["properties.configuration.ingress.fqdn"]
}