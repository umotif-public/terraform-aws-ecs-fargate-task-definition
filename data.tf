data "aws_region" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "task_permissions" {
  statement {
    effect = "Allow"

    resources = ["*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }
}

data "aws_kms_key" "secretsmanager_key" {
  key_id = var.repository_credentials_kms_key
}

data "aws_iam_policy_document" "read_repository_credentials" {
  statement {
    effect = "Allow"

    resources = [
      var.repository_credentials,
      data.aws_kms_key.secretsmanager_key.arn,
    ]

    actions = [
      "secretsmanager:GetSecretValue",
      "kms:Decrypt",
    ]
  }
}
