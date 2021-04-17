data "null_data_source" "wait_for_lambda_build" {
  for_each = local.lambdas

  inputs = {
    lambda_build_id = null_resource.lambda_build[each.key].id
    source          = "${path.module}/lambdas/bin/${each.key}"
  }
}

data "archive_file" "this" {
  for_each = local.lambdas

  type        = "zip"
  source_file = data.null_data_source.wait_for_lambda_build[each.key].outputs["source"]
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

