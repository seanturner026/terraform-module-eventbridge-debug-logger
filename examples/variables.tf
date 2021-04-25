variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
}

variable "name" {
  type        = string
  description = "Common name shared between resources."
}

variable "service_name" {
  type        = string
  description = <<-DESC
  Name of the service to create a catch-all eventbridge rule for.

  See variables.tf for a complete list of input options.
  DESC

  validation {
    condition = contains([
      "access-analyzer",
      "forecast",
      "apigateway",
      "appflow",
      "application-autoscaling",
      "athena",
      "autoscaling",
      "codestar",
      "connect",
      "databrew",
      "xray",
      "backup",
      "batch",
      "acm",
      "acm-pca",
      "clouddirectory",
      "cloudformation",
      "cloudhsm",
      "cloudsearch",
      "cloudtrail",
      "cloudwatch",
      "applicationinsights",
      "logs",
      "synthetics",
      "codeartifact",
      "codebuild",
      "codecommit",
      "codedeploy",
      "codepipeline",
      "config",
      "controltower",
      "dataexchange",
      "dlm",
      "datapipeline",
      "dms",
      "datasync",
      "directconnect",
      "ds",
      "dynamodb",
      "ec2",
      "ec2fleet",
      "ec2spotfleet",
      "elasticbeanstalk",
      "ecr",
      "ecs",
      "elasticloadbalancing",
      "elasticmapreduce",
      "elastictranscoder",
      "elasticache",
      "es",
      "mediapackage",
      "emr",
      "events",
      "schemas",
      "gamelift",
      "glacier",
      "glue",
      "greengrass",
      "groundstation",
      "guardduty",
      "health",
      "iotanalytics",
      "kms",
      "kinesis",
      "lambda",
      "macie",
      "mediaconvert",
      "medialive",
      "mediastore",
      "metering-marketplace",
      "monitoring",
      "opsworks",
      "redshift",
      "redshift-data",
      "rds",
      "ram",
      "s3-outposts",
      "sagemaker",
      "secretsmanager",
      "securityhub",
      "sts",
      "sms",
      "servicecatalog",
      "signer",
      "sns",
      "sqs",
      "s3",
      "swf",
      "states",
      "storagegateway",
      "ssm",
      "tag",
      "transcribe",
      "waf",
      "workdocs",
      "workspaces", ],
      var.service_name
    )
    error_message = "The provided value is not supported for service_name, consult the module variables.tf for the possible input values."
  }
}
