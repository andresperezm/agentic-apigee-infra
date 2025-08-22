variable "project" {
  type        = string
  description = "Google Cloud project"
}

variable "mcp_service_name" {
  type        = string
  description = "Name of the Apigee MCP service"
}

variable "mcp_image_name" {
  type        = string
  description = "Name of the Apigee MCP image"
}

variable "mcp_image_version" {
  type        = string
  description = "Version of the Apigee MCP image"
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
