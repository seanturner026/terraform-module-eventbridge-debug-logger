output "cloudwatch_log_group_arn" {
  description = "ARN of cloudwatch log group which holds service-specific log events."
  value       = aws_cloudwatch_log_group.this["events_debug_logger"].arn
}

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group which holds service-specific log events."
  value       = aws_cloudwatch_log_group.this["events_debug_logger"].name
}

output "event_bus_arn" {
  description = "ARN of the event bridge eventbus."
  value       = aws_cloudwatch_event_bus.this.arn
}

output "event_bus_name" {
  description = "Name of the event bridge eventbus."
  value       = aws_cloudwatch_event_bus.this.name
}

output "event_rule_arn" {
  description = "ARN of the event bridge rule."
  value       = aws_cloudwatch_event_rule.this.arn
}

output "event_rule_id" {
  description = "ID of the event bridge rule."
  value       = aws_cloudwatch_event_rule.this.id
}

output "event_rule_name" {
  description = "Name of the event bridge rule."
  value       = aws_cloudwatch_event_rule.this.name
}

output "event_target_arn" {
  description = "ARN of the resource targeted by the eventbridge target."
  value       = aws_cloudwatch_event_target.this.arn
}

output "event_target_rule" {
  description = "Eventbridge rule responsible for invoking the target."
  value       = aws_cloudwatch_event_target.this.rule
}
