output "saw_command" {
  value = "saw watch ${module.eventbridge_debug_logger.cloudwatch_log_group_name} --expand"
}
