variable "project" {
  type        = string
  description = "Google Cloud project"
}

variable "uris" {
  type        = set(string)
  description = "List of sites to index on the datastore"
}

variable "location" {
  type        = string
  default     = "us-east1"
  description = "List of sites to index on the datastore"
}

variable "agent_accessors" {
  type        = list(string)
  default     = []
  description = "List od strings allowed to access the Apigee Agents"
}

variable "agents_service_name" {
  type        = string
  default     = "apigee-agents"
  description = "Name of the Apigee Agents service"
}

variable "agents_image_name" {
  type        = string
  default     = "apigee-agents"
  description = "Name of the Apigee Agents image"
}

variable "agents_image_version" {
  type        = string
  default     = "latest"
  description = "Version of the Apigee Agents image"
}

variable "mcp_service_name" {
  type        = string
  default     = "apigee-mcp-server"
  description = "Name of the Apigee MCP service"
}

variable "mcp_image_name" {
  type        = string
  default     = "apigee-mcp-server"
  description = "Name of the Apigee MCP image"
}

variable "mcp_image_version" {
  type        = string
  default     = "latest"
  description = "Version of the Apigee MCP image"
}
