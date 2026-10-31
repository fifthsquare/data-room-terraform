locals {
  app_url = "https://${var.webapp_name}.${azapi_resource.environment.output.properties.defaultDomain}"

  app_env = {
    NEXTAUTH_URL           = local.app_url
    AUTH_REDIRECT_URL      = "${local.app_url}/api/auth/callback/azure-ad"
    NEXTAUTH_SECRET        = var.nextauth_secret
    AZURE_AD_CLIENT_ID     = var.azure_ad_client_id
    AZURE_AD_CLIENT_SECRET = var.azure_ad_client_secret
    AZURE_AD_TENANT_ID     = var.azure_ad_tenant_id


    DATABASE_URL        = var.database_url
    DATABASE_URL_POOLED = var.database_url_pooled

    STORAGE_PROVIDER                = var.storage_provider
    AZURE_STORAGE_CONNECTION_STRING = var.azure_storage_connection_string
    AZURE_STORAGE_ACCOUNT_NAME      = var.azure_storage_account_name
    AZURE_STORAGE_ACCOUNT_KEY       = var.azure_storage_account_key
    AZURE_STORAGE_CONTAINER_NAME    = var.azure_storage_container_name


    # Azure AI
    OPENAI_COMPATIBLE_API_KEY  = var.openai_compatible_api_key
    OPENAI_COMPATIBLE_BASE_URL = var.openai_compatible_base_url
    OPENAI_COMPATIBLE_MODEL    = var.openai_compatible_model

    # AI Observability
    LANGFUSE_PUBLIC_KEY = var.langfuse_public_key
    LANGFUSE_SECRET_KEY = var.langfuse_secret_key
    LANGFUSE_BASE_URL   = var.langfuse_base_url
  }
}