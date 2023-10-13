variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
}

variable "name" {
  type        = string
  description = "Common name shared between resources."
}

variable "service_name" {
  type        = string
  description = <<-DESC
  Name of the service to create a catch-all eventbridge rule for.

  See variables.tf for a complete list of input options.
  DESC
}
