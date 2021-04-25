resource "aws_cloudwatch_log_group" "this" {
  for_each = local.lambdas

  name              = "/aws/lambda/${each.key}_${local.service_name}"
  retention_in_days = var.lambda_logs_retention_in_days
  tags              = var.tags
}

resource "aws_cloudwatch_event_bus" "this" {
  name = "${var.name}_${local.service_name}"
  tags = var.tags
}

resource "aws_cloudwatch_event_rule" "this" {
  name           = "${var.name}_${local.service_name}_star_rule"
  description    = "Capture all ${var.service_name} events"
  event_bus_name = aws_cloudwatch_event_bus.this.name

  event_pattern = jsonencode({
    "source" : ["aws.${var.service_name}"],
  })

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "this" {
  event_bus_name = aws_cloudwatch_event_bus.this.id
  arn            = aws_lambda_function.this["events_debug_logger"].arn
  rule           = aws_cloudwatch_event_rule.this.name

  retry_policy {
    maximum_event_age_in_seconds = 300
    maximum_retry_attempts       = 2
  }
}
