output "task_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the ECS service role."
  value       = var.enabled ? aws_iam_role.task[0].arn : null
}

output "task_role_name" {
  description = "The name of the Fargate task service role."
  value       = var.enabled ? aws_iam_role.task[0].name : null
}

output "task_role_create_date" {
  description = "The creation date of the IAM role."
  value       = var.enabled ? aws_iam_role.task[0].create_date : null
}

output "task_role_id" {
  description = "The ID of the role."
  value       = var.enabled ? aws_iam_role.task[0].id : null
}

output "task_role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = var.enabled ? aws_iam_role.task[0].unique_id : null
}

output "execution_role_arn" {
  description = "The Amazon Resource Name (ARN : null of execution role."
  value       = var.enabled ? aws_iam_role.execution[0].arn : null
}

output "execution_role_name" {
  description = "The name of the execution service role."
  value       = var.enabled ? aws_iam_role.execution[0].name : null
}

output "execution_role_create_date" {
  description = "The creation date of the IAM role."
  value       = var.enabled ? aws_iam_role.execution[0].create_date : null
}

output "execution_role_id" {
  description = "The ID of the execution role."
  value       = var.enabled ? aws_iam_role.execution[0].id : null
}

output "execution_role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = var.enabled ? aws_iam_role.execution[0].unique_id : null
}

output "task_definition_arn" {
  description = "Full ARN of the Task Definition (including both family and revision)."
  value       = var.enabled ? aws_ecs_task_definition.task[0].arn : null
}

output "task_definition_family" {
  description = "The family of the Task Definition."
  value       = var.enabled ? aws_ecs_task_definition.task[0].family : null
}

output "task_definition_revision" {
  description = "The revision of the task in a particular family."
  value       = var.enabled ? aws_ecs_task_definition.task[0].revision : null
}

output "container_port" {
  description = "Port on which the container is listening."
  value       = var.enabled ? var.task_container_port : null
}
