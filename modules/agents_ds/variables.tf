variable "project" {
  type        = string
  description = "Google Cloud project"
}

variable "location" {
  type        = string
  default     = "global"
  description = "location of the datastore"
}

variable "datastore_name" {
  type        = string
  default     = "apigee-knowledge-datastore"
  description = "Name of the datastore"
}

variable "uris" {
  type        = set(string)
  description = "List of sites to index on the datastore"
}
