resource "aws_lambda_function" "this" {
  for_each = local.lambdas

  filename         = "${path.module}/lambdas/archive/${each.key}.zip"
  function_name    = "${each.key}_${local.service_name}"
  description      = each.value.description
  role             = aws_iam_role.this.arn
  handler          = each.key
  publish          = false
  source_code_hash = data.archive_file.this[each.key].output_base64sha256
  runtime          = "go1.x"
  timeout          = "10"
  tags             = var.tags
}

resource "aws_lambda_permission" "this" {
  action        = "lambda:InvokeFunction"
  statement_id  = "AllowExecutionFromEvents-${join("", [for word in split("_", local.service_name) : title(word)])}"
  function_name = aws_lambda_function.this["events_logger"].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}
