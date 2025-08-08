variable "project" {
  type = string
  description = "Google Cloud project"
}

variable "mcp_service_name" {
  type = string
  default = "apigee-mcp-server"
  description = "Name of the Apigee MCP server"
}