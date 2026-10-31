terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azapi = {
      source = "Azure/azapi"
    }
    azuread = {
      source = "hashicorp/azuread"
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

provider "azuread" {

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
  response_export_values = ["properties.defaultDomain"]
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
          targetPort = 3000
          transport  = "auto"
        }
        secrets = [
          {
            name  = "ghcr-pat"
            value = var.ghcr_pat
          }
        ]
        registries = [
          {
            server            = "ghcr.io"
            username          = var.ghcr_username
            passwordSecretRef = "ghcr-pat"
          }
        ]
      }
      template = {
        containers = [
          {
            name  = "main"
            image = "${var.image_path}:${var.image_version}"
            resources = {
              cpu    = 0.5
              memory = "1.0Gi"
            }
            env = [
              for k, v in local.app_env : {
                name  = k
                value = v
              } if v != "" && v != null
            ]
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