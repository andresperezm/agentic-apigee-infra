variable "project" {
  type = string
  description = "Google Cloud project"
}

variable "location" {
  type = string
  default = "global"
  description = "location of the datastore"
}

variable "uris" {
  type = set(string)
  description = "List of sites to index on the datastore"
}