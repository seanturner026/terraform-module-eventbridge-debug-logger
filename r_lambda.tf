resource "null_resource" "lambda_build" {
  for_each = local.lambdas

  triggers = {
    binary_exists = local.null.lambda_binary_exists[each.key]

    main = join("", [
      for file in fileset("${path.module}/lambdas/cmd/${each.key}", "*.go") : filebase64("${path.module}/lambdas/cmd/${each.key}/${file}")
    ])
  }

  provisioner "local-exec" {
    command = "export GO111MODULE=on"
  }

  provisioner "local-exec" {
    command = "GOOS=linux go build -ldflags '-s -w' -o ${path.module}/lambdas/bin/${each.key} ${path.module}/lambdas/cmd/${each.key}/."
  }
}

resource "aws_lambda_function" "this" {
  for_each = local.lambdas

  filename         = "${path.module}/archive/${each.key}.zip"
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
  function_name = aws_lambda_function.this["events_debug_logger"].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}
