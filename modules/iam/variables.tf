variable "project" {
  type        = string
  description = "Google Cloud project"
}

variable "agents_service_name" {
  type        = string
  default     = "apigee-agents"
  description = "Name of the Apigee Agents service"
}

variable "mcp_service_name" {
  type        = string
  default     = "apigee-mcp-server"
  description = "Name of the Apigee MCP server"
}
