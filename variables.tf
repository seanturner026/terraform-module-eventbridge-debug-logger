variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
}

variable "lambda_logs_retention_in_days" {
  type        = number
  description = <<-DESC
  Specifies the number of days you want to retain log events in the specified lambda log group.

  Specifying "0" means logs are permanently retained.
  DESC
  default     = 1
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
    condition = contains(
      [
        "a4b", // alexa for business
        "access-analyzer",
        "acm",
        "acm-pca",
        "apigateway",
        "appflow",
        "application-autoscaling",
        "application-cost-profiler",
        "applicationinsights", // cloudwatch application insights
        "athena",
        "autoscaling",
        "aws.opsworks-cm", // opsworks for chef automate
        "backup",
        "batch",
        "braket",
        "chime",
        "clouddirectory",
        "cloudformation",
        "cloudhsm",
        "cloudsearch",
        "cloudshell",
        "cloudtrail",
        "cloudwatch",
        "codeartifact",
        "codebuild",
        "codecommit",
        "codedeploy",
        "codepipeline",
        "codestar",
        "codestar-connections",
        "cognito-identity",
        "cognito-idp",
        "cognito-sync",
        "config",
        "connect",
        "controltower",
        "databrew",
        "dataexchange",
        "datapipeline",
        "datasync",
        "devops-guru",
        "directconnect",
        "dlm",
        "dms",
        "drs", // elastic disater recovery service
        "ds",
        "dynamodb",
        "ec2",
        "ec2fleet",
        "ec2spotfleet",
        "ecr",
        "ecs",
        "elasticache",
        "elasticbeanstalk",
        "elasticfilesystem",
        "elasticloadbalancing",
        "elasticmapreduce",
        "elastictranscoder",
        "emr",
        "emr-containers",
        "es",     // amazon opensearch service (elasticsearch service)
        "events", // eventbridge
        "firehose",
        "fis",
        "forecast",
        "gamelift",
        "geo", // amazon location service
        "glacier",
        "glue",
        "greengrass",
        "groundstation",
        "guardduty",
        "health",
        "iam",
        "inspector2",
        "inspector",
        "iot",
        "iotanalytics",
        "ivs", // interactive video service
        "kinesis",
        "kms",
        "lambda",
        "logs", // cloudwatch logs
        "machinelearning",
        "macie",
        "managedblockchain",
        "managedservices",
        "mediaconnect",
        "mediaconvert",
        "medialive",
        "mediapackage", // elemental media package
        "mediastore",
        "metering-marketplace",
        "mgn", // application migration service
        "migrationhub",
        "monitoring",
        "opsworks",
        "organizations",
        "polly",
        "proton",
        "qldb",
        "ram",
        "rds",
        "redshift",
        "redshift-data",
        "refactor-spaces", // migration hub refactor spaces
        "s3",
        "s3-outposts",
        "sagemaker",
        "savingsplans",
        "schemas", // eventbridge schema registry
        "secretsmanager",
        "securityhub",
        "servicecatalog",
        "signer",
        "signin", // console sign-in
        "sms",    // server migration service
        "sns",
        "sqs",
        "ssm",
        "states",
        "storagegateway",
        "sts",
        "support",
        "swf",        // simple worfklow service
        "synthetics", // cloudwatch synthetics
        "tag",
        "transcribe",
        "translate",
        "voiceid",
        "waf",
        "workdocs",
        "workspaces",
        "xray",
      ], var.service_name
    )
    error_message = "The provided value is not supported for service_name, consult the module variables.tf for the possible input values."
  }
}
