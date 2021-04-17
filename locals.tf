locals {
  service_name = replace(var.service_name, "-", "_")

  lambdas = {
    events_debug_logger = {
      description = "Logs eventbridge events for ${var.service_name}."
      timeout     = 10
    }
  }
}
