data "archive_file" "this" {
  for_each = local.lambdas

  type        = "zip"
  source_file = "${path.module}/lambdas/cmd/events_logger/main.py"
  output_path = "${path.module}/lambdas/archive/${each.key}.zip"
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
