variable "project" {
  type = string
  description = "Google Cloud project"
}

variable "uris" {
  type = set(string)
  description = "List of sites to index on the datastore"
}
