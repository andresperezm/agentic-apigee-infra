variable "project" {
  type = string
  description = "Google Cloud project"
}

variable "agents_service_name" {
  type = string
  default = "apigee-agents"
  description = "Name of the Apigee Agents service"
}