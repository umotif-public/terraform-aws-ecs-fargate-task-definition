output "task_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the ECS service role."
  value       = join("", aws_iam_role.task.*.arn)
}

output "task_role_name" {
  description = "The name of the Fargate task service role."
  value       = join("", aws_iam_role.task.*.name)
}

output "task_role_create_date" {
  description = "The creation date of the IAM role."
  value       = join("", aws_iam_role.task.*.create_date)
}

output "task_role_id" {
  description = "The ID of the role."
  value       = join("", aws_iam_role.task.*.id)
}

output "task_role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = join("", aws_iam_role.task.*.unique_id)
}

output "execution_role_arn" {
  description = "The Amazon Resource Name (ARN) of execution role."
  value       = join("", aws_iam_role.execution.*.arn)
}

output "execution_role_name" {
  description = "The name of the execution service role."
  value       = join("", aws_iam_role.execution.*.name)
}

output "execution_role_create_date" {
  description = "The creation date of the IAM role."
  value       = join("", aws_iam_role.execution.*.create_date)
}

output "execution_role_id" {
  description = "The ID of the execution role."
  value       = join("", aws_iam_role.execution.*.id)
}

output "execution_role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = join("", aws_iam_role.execution.*.unique_id)
}

output "task_definition_arn" {
  description = "Full ARN of the Task Definition (including both family and revision)."
  value       = join("", aws_ecs_task_definition.task.*.arn)
}

output "task_definition_family" {
  description = "The family of the Task Definition."
  value       = join("", aws_ecs_task_definition.task.*.family)
}

output "task_definition_revision" {
  description = "The revision of the task in a particular family."
  value       = join("", aws_ecs_task_definition.task.*.revision)
}

output "container_port" {
  description = "Port on which the container is listening."
  value       = var.task_container_port
}
