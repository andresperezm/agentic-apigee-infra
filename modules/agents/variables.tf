variable "project" {
  type        = string
  description = "Google Cloud project"
}

variable "agents_service_name" {
  type        = string
  description = "Name of the Apigee Agents service"
}

variable "agents_image_name" {
  type        = string
  description = "Name of the Apigee Agents image"
}

variable "agents_image_version" {
  type        = string
  description = "Version of the Apigee Agents image"
}

variable "agent_accessors" {
  type        = list(string)
  default     = []
  description = "List od strings allowed to access the Apigee Agents"
}

variable "location" {
  type        = string
  description = "location of the datastore"
}

variable "datastore_id" {
  type        = string
  description = "Id of the web datastore that contains the documentation"
}

variable "db_connection_name" {
  type        = string
  description = "Connection name of the Cloud SQL instance"
}

variable "db_name_secret_id" {
  type        = string
  description = "Id of the secret containing the DB name"
}

variable "db_user_secret_id" {
  type        = string
  description = "Id of the secret containing the DB user"
}

variable "db_password_secret_id" {
  type        = string
  description = "Id of the secret containing the DB password"
}

variable "mcp_server_url" {
  type        = string
  description = "URL of the MCP server"
}

variable "agents_sa_email" {
  type        = string
  description = "Email of the SA used by the agents service"
}
