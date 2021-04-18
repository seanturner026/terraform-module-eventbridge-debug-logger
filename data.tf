data "archive_file" "this" {
  depends_on = [null_resource.lambda_build]
  for_each   = local.lambdas

  type        = "zip"
  source_file = local.null.lambda_binary_locations[each.key]
  output_path = "${path.module}/archive/${each.key}.zip"
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

