output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group which holds service-specific log events."
  value       = aws_cloudwatch_log_group.this["events_debug_logger"].name
}
