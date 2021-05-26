resource "null_resource" "go_setup" {

  triggers = {
    hash_go_mod = filemd5("${local.main_module_path}/go.mod")
    hash_go_sum = filemd5("${local.main_module_path}/go.sum")
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "cp -f ${local.main_module_path}/go.mod ."
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "cp -f ${local.main_module_path}/go.sum ."
  }
}

resource "null_resource" "lambda_build" {
  for_each   = local.lambdas
  depends_on = [null_resource.go_setup]

  triggers = {
    binary_exists = local.null.lambda_binary_exists[each.key]

    main = join("", [
      for file in fileset("${path.module}/lambdas/cmd/${each.key}", "*.go") : filemd5("${path.module}/lambdas/cmd/${each.key}/${file}")
    ])
  }

  provisioner "local-exec" {
    command = "export GO111MODULE=on"
  }

  provisioner "local-exec" {
    command = "cd ${local.main_module_path} && GOOS=linux go build -ldflags '-s -w' -o ./lambdas/bin/${each.key} ./lambdas/cmd/${each.key}/main.go"
  }
}
