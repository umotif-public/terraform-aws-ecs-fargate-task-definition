#####
# Execution IAM Role
#####
resource "aws_iam_role" "execution" {
  count = var.enabled ? 1 : 0

  name               = "${var.name_prefix}-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attach" {
  count = var.enabled ? 1 : 0

  role       = aws_iam_role.execution[0].name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "read_repository_credentials" {
  count = var.create_repository_credentials_iam_policy && var.enabled ? 1 : 0

  name   = "${var.name_prefix}-read-repository-credentials"
  role   = aws_iam_role.execution[0].id
  policy = data.aws_iam_policy_document.read_repository_credentials[0].json
}

#####
# IAM - Task role, basic. Append policies to this role for S3, DynamoDB etc.
#####
resource "aws_iam_role" "task" {
  count = var.enabled ? 1 : 0

  name               = "${var.name_prefix}-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = var.tags
}

resource "aws_iam_role_policy" "log_agent" {
  count = var.enabled ? 1 : 0

  name   = "${var.name_prefix}-log-permissions"
  role   = aws_iam_role.task[0].id
  policy = data.aws_iam_policy_document.task_permissions.json
}

#####
# ECS task definition
#####

locals {
  task_environment = [
    for k, v in var.task_container_environment : {
      name  = k
      value = v
    }
  ]
}

resource "aws_ecs_task_definition" "task" {
  count = var.enabled ? 1 : 0

  family                   = var.name_prefix
  execution_role_arn       = aws_iam_role.execution[0].arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory
  task_role_arn            = aws_iam_role.task[0].arn

  container_definitions = <<EOF
[{
    "name": "${var.container_name != "" ? var.container_name : var.name_prefix}",
    "image": "${var.task_container_image}",
    %{if var.repository_credentials != ""~}
    "repositoryCredentials": {
      "credentialsParameter": "${var.repository_credentials}"
    },
    %{~endif}
    "essential": true,
    %{if var.task_container_port != 0 || var.task_host_port != 0~}
    "portMappings": [
      {
        %{if var.task_host_port != 0~}
        "hostPort": ${var.task_host_port},
        %{~endif}
        %{if var.task_container_port != 0~}
        "containerPort": ${var.task_container_port},
        %{~endif}
        "protocol":"tcp"
      }
    ],
    %{~endif}
    %{if var.cloudwatch_log_group_name != ""~}
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.cloudwatch_log_group_name}",
        "awslogs-region": "${data.aws_region.current.name}",
        "awslogs-stream-prefix": "container"
      }
    },
    %{~endif}
    %{if var.task_health_check != null~}
    "healthcheck": {
        "command": ${jsonencode(var.task_health_check.command)},
        "interval": ${var.task_health_check.interval},
        "timeout": ${var.task_health_check.timeout},
        "retries": ${var.task_health_check.retries},
        "startPeriod": ${var.task_health_check.startPeriod}
    },
    %{~endif}
    "command": ${jsonencode(var.task_container_command)},
    %{if var.task_container_working_directory != ""~}
    "workingDirectory": ${jsonencode(var.task_container_working_directory)},
    %{~endif}
    %{if var.task_container_memory != null~}
    "memory": ${var.task_container_memory},
    %{~endif}
    %{if var.task_container_memory_reservation != null~}
    "memoryReservation": ${var.task_container_memory_reservation},
    %{~endif}
    %{if var.task_container_cpu != null~}
    "cpu": ${var.task_container_cpu},
    %{~endif}
    %{if var.task_start_timeout != null~}
    "startTimeout": ${var.task_start_timeout},
    %{~endif}
    %{if var.task_stop_timeout != null~}
    "stopTimeout": ${var.task_stop_timeout},
    %{~endif}
    %{if var.task_mount_points != null~}
    "mountPoints": ${jsonencode(var.task_mount_points)},
    %{~endif}
    %{if var.task_container_secrets != null~}
    "secrets": ${jsonencode(var.task_container_secrets)},
    %{~endif}
    "environment": ${jsonencode(local.task_environment)}
}]
EOF

  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      expression = lookup(placement_constraints.value, "expression", null)
      type       = placement_constraints.value.type
    }
  }

  dynamic "proxy_configuration" {
    for_each = var.proxy_configuration
    content {
      container_name = proxy_configuration.value.container_name
      properties     = lookup(proxy_configuration.value, "properties", null)
      type           = lookup(proxy_configuration.value, "type", null)
    }
  }

  dynamic "volume" {
    for_each = var.volume
    content {
      name      = volume.value.name
      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          scope         = lookup(docker_volume_configuration.value, "scope", null)
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])
        content {
          file_system_id          = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory          = lookup(efs_volume_configuration.value, "root_directory", null)
          transit_encryption      = lookup(efs_volume_configuration.value, "transit_encryption", null)
          transit_encryption_port = lookup(efs_volume_configuration.value, "transit_encryption_port", null)

          dynamic "authorization_config" {
            for_each = length(lookup(efs_volume_configuration.value, "authorization_config")) == 0 ? [] : [lookup(efs_volume_configuration.value, "authorization_config", {})]
            content {
              access_point_id = lookup(authorization_config.value, "access_point_id", null)
              iam             = lookup(authorization_config.value, "iam", null)
            }
          }
        }
      }
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.container_name != "" ? var.container_name : var.name_prefix
    }
  )
}

