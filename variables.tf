variable "resource_group_name" {
  default = "data-room"
}

variable "resource_group_team" {
  default = "Data Room"
}

variable "location" {
  default = "westus"
}

variable "webapp_env" {
  default = "data-room-env"
}


variable "webapp_name" {
  default = "data-room"
}

variable "image_path" {
  default = "ghcr.io/fifthsquare/data-room-demo"
}

variable "image_version" {
  default = "sha-39e0f34"
}

# Auth
variable "nextauth_secret" {
  default   = ""
  sensitive = true
}

variable "azure_ad_client_id" {
  default = ""
}

variable "azure_ad_client_secret" {
  default   = ""
  sensitive = true
}

variable "azure_ad_tenant_id" {
  default = ""
}

# Database
variable "database_url" {
  default   = ""
  sensitive = true
}

variable "database_url_pooled" {
  default     = ""
  sensitive   = true
  description = "Pooled connection string for Neon / PostgreSQL"
}

# Storage
variable "storage_provider" {
  default = "azure"
}

variable "azure_storage_connection_string" {
  default   = ""
  sensitive = true
}

variable "azure_storage_account_name" {
  default = ""
}

variable "azure_storage_account_key" {
  default   = ""
  sensitive = true
}

variable "azure_storage_container_name" {
  default = "data-room-poc"
}

# AI
variable "openai_api_key" {
  default   = ""
  sensitive = true
}

variable "openai_base_url" {
  default = ""
}

variable "openai_model" {
  default = "gpt-4o"
}

# Observability
variable "langfuse_public_key" {
  default = ""
}

variable "langfuse_secret_key" {
  default   = ""
  sensitive = true
}

variable "langfuse_baseurl" {
  default = "https://cloud.langfuse.com"
}

variable "ghcr_username" {
  type        = string
  description = "GitHub username"
  default     = ""
}

variable "ghcr_pat" {
  type        = string
  description = "GitHub Personal Access Token with read:packages permission"
  default     = ""
  sensitive   = true
}


variable "openai_reasoning_effort" {
  default = "low"
}