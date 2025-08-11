variable "project" {
  type = string
  description = "Google Cloud project"
}

variable "uris" {
  type = set(string)
  description = "List of sites to index on the datastore"
}

variable "db_location" {
  type = string
  default = "us-east1"
  description = "List of sites to index on the datastore"
}
