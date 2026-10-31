data "azuread_application" "app" {
  client_id = var.azure_ad_client_id
}

resource "azuread_application_redirect_uris" "webapp" {
  application_id = data.azuread_application.app.id
  type           = "Web"
  redirect_uris = distinct(concat(
    # 1. Fetch whatever redirect URIs already exist in Entra ID (e.g. localhost, old app service)
    try(data.azuread_application.app.web[0].redirect_uris, []),
    # 2. Append the new Azure Container App URL
    [
      "https://${azapi_resource.app.output.properties.configuration.ingress.fqdn}/api/auth/callback/azure-ad"
    ]
  ))
}