module "eventbridge_debug_logger" {
  source = "../"

  name                          = var.name
  service_name                  = var.service_name
  lambda_logs_retention_in_days = 1
  tags                          = var.tags
}
