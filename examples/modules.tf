module "eventbridge_debug_logger" {
  source = "../"

  name                          = "eventbridge_debug_logger"
  service_name                  = "ec2"
  lambda_logs_retention_in_days = 1
  tags                          = var.tags
}
