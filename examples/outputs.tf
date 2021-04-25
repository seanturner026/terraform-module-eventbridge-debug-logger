output "saw_command" {
  description = "Tails lambda log group with saw"
  value       = "saw watch ${module.eventbridge_debug_logger.cloudwatch_log_group_name} --expand"
}
