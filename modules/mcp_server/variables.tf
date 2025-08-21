variable "project" {
  type        = string
  description = "Google Cloud project"
}

variable "mcp_service_name" {
  type        = string
  default     = "apigee-mcp-server"
  description = "Name of the Apigee MCP server"
}

variable "location" {
  type        = string
  description = "location of the datastore"
}

variable "agents_sa_email" {
  type        = string
  description = "Email of the SA used by the agents service"
}

variable "mcp_server_sa_email" {
  type        = string
  description = "Email of the SA used by the agents service"
}
