locals {
  service_name = replace(var.service_name, "-", "_")

  lambdas = {
    events_logger = {
      description = "Logs eventbridge events for ${var.service_name}."
      timeout     = 10
    }
  }

  null = {
    lambda_binary_exists = { for key, _ in local.lambdas : key => fileexists("${path.module}/lambdas/bin/${key}") }
  }
}
