# terraform-module-eventbridge-debug-logger

A terraform module to create resources for capturing all eventbridge events for a given service as cloudwatch logs. 

This is a developer workflow productivity tool that can be used to log events created by any service in order to see the event json schema, which is necessary in order to produce workflows around eventbridge rules.

## Contributing

Ensure that the pre-commit hooks are installed by running the following command: `pre-commit install`

## Usage example

Full example(s) leveraging this module is contained in the [examples](https://github.com/seanturner026/terraform-module-eventbridge-debug-logger/tree/master/examples/).

**IMPORTANT**: The master branch is used in source just as an example. In your code, do not pin to master because there may be breaking changes between releases. Instead pin to the release tag (e.g. `git@github.com:seanturner026/terraform-module-eventbridge-debug-logger.git?ref=vX.Y.Z`) using one of the [latest releases](https://github.com/seanturner026/terraform-module-eventbridge-debug-logger/releases/).

```hcl
module "eventbridge_debug_logger" {
  source = "git@github.com:seanturner026/terraform-module-eventbridge-debug-logger.git"

  name                          = "eventbridge_debug_logger"
  service_name                  = "ec2"
  lambda_logs_retention_in_days = 1
  tags                          = var.tags
}
```

The above example module invocation will track all ec2 events. Using a tool like [saw](https://github.com/TylerBrock/saw) to tail cloudwatch logs, the following log events will be written by launching and terminating an EC2 instance.

```
$ saw watch /aws/lambda/events_debug_logger_ec2 --expand
[2021-04-17T12:30:43+12:00] START RequestId: 9130fe6d-4a72-460f-87bb-2e3ede273772 Version: $LATEST
[2021-04-17T12:30:43+12:00] {
    "account-id": "123456789012",
    "detail": {
        "instance-id": "i-0e12345678cdfc123",
        "state": "pending"
    },
    "detail-type": "EC2 Instance State-change Notification",
    "id": "01d4aadf-a202-ed3e-0464-8bb84910a8ec",
    "region": "us-east-1",
    "resources": [
        "arn:aws:ec2:us-east-1:123456789012:instance/i-0e12345678cdfc123"
    ],
    "source": "aws.ec2",
    "version": "0",
    "level": "info",
    "msg": "handled event",
    "time": "2021-04-17T00:30:43Z"
}
[2021-04-17T12:30:43+12:00] END RequestId: 9130fe6d-4a72-460f-87bb-2e3ede273772
[2021-04-17T12:30:43+12:00] REPORT RequestId: 9130fe6d-4a72-460f-87bb-2e3ede273772	Duration: 0.88 ms	Billed Duration: 1 ms	Memory Size: 128 MB	Max Memory Used: 30 MB	Init Duration: 74.44 ms
[2021-04-17T12:33:58+12:00] START RequestId: 4c13af9e-3b16-4f8e-b8ac-56f524a6435e Version: $LATEST
[2021-04-17T12:33:58+12:00] {
    "account": "123456789012",
    "detail": {
        "instance-id": "i-0e12345678cdfc123",
        "state": "shutting-down"
    },
    "detail-type": "EC2 Instance State-change Notification",
    "id": "cb3e793e-613b-a733-91e3-b92907d6f9fd",
    "level": "info",
    "msg": "handled event",
    "region": "us-east-1",
    "resources": [
        "arn:aws:ec2:us-east-1:123456789012:instance/i-0e12345678cdfc123"
    ],
    "source": "aws.ec2",
    "time": "2021-04-17T00:33:58Z",
    "version": "0"
}
[2021-04-17T12:33:58+12:00] END RequestId: 4c13af9e-3b16-4f8e-b8ac-56f524a6435e
[2021-04-17T12:33:58+12:00] REPORT RequestId: 4c13af9e-3b16-4f8e-b8ac-56f524a6435e	Duration: 1.14 ms	Billed Duration: 2 ms	Memory Size: 128 MB	Max Memory Used: 31 MB	Init Duration: 61.97 ms
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| archive | >= 2.0 |
| aws | >= 3.0 |
| null | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| archive | >= 2.0 |
| aws | >= 3.0 |
| null | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| lambda\_logs\_retention\_in\_days | Specifies the number of days you want to retain log events in the specified lambda log group.<br><br>Specifying "0" means logs are permanently retained. | `number` | `1` | no |
| name | Common name shared between resources. | `string` | n/a | yes |
| service\_name | Name of the service to create a catch-all eventbridge rule for.<br><br>See variables.tf for a complete list of input options. | `string` | n/a | yes |
| tags | A map of tags to add to all resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch\_log\_group\_name | Name of cloudwatch log group which holds service-specific log events. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
