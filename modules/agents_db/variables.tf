variable "project" {
  type        = string
  description = "Google Cloud project"
}

variable "location" {
  type        = string
  description = "location of the datastore"
}

variable "agents_sa_email" {
  type        = string
  description = "Email of the SA used by the agents service"
}
