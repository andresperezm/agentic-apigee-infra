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
