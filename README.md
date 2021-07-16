![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/umotif-public/terraform-aws-ecs-fargate-task-definition?style=social)

# terraform-aws-ecs-fargate-task-definition
Terraform module to create AWS ECS Fargate Task Definition.

## Terraform versions

Terraform 0.12. Pin module version to `~> v2.0`. Submit pull-requests to `master` branch.

## Usage

```hcl
module "ecs-task-definition" {
  source = "umotif-public/ecs-fargate-task-definition/aws"
  version = "~> 2.0.0"

  enabled              = true
  name_prefix          = "test-container"
  task_container_image = "httpd:2.4"

  container_name      = "test-container-name"
  task_container_port = "80"
  task_host_port      = "80"

  task_definition_cpu    = "512"
  task_definition_memory = "1024"

  task_container_environment = {
    "ENVIRONEMNT" = "Test"
  }
}
```

## Assumptions

Module is to be used with Terraform > 0.12.

## Examples

* [ECS Fargate Task Definition](https://github.com/umotif-public/terraform-aws-ecs-fargate-task-definition/tree/master/examples/core)
* [ECS Fargate Task Definition with EFS](https://github.com/umotif-public/terraform-aws-ecs-fargate-task-definition/tree/master/examples/task-efs)

## Authors

Module managed by [Marcin Cuber](https://github.com/marcincuber) [LinkedIn](https://www.linkedin.com/in/marcincuber/).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.68 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.68 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.log_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.read_repository_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_role_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_repository_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.secretsmanager_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#input\_cloudwatch\_log\_group\_name) | CloudWatch log group name required to enabled logDriver in container definitions for ecs task. | `string` | `""` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Optional name for the container to be used instead of name\_prefix. | `string` | `""` | no |
| <a name="input_create_repository_credentials_iam_policy"></a> [create\_repository\_credentials\_iam\_policy](#input\_create\_repository\_credentials\_iam\_policy) | Set to true if you are specifying `repository_credentials` variable, it will attach IAM policy with necessary permissions to task role. | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to create the resources. Set to `false` to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | A prefix used for naming resources. | `string` | n/a | yes |
| <a name="input_placement_constraints"></a> [placement\_constraints](#input\_placement\_constraints) | (Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10. This is a list of maps, where each map should contain "type" and "expression" | `list(any)` | `[]` | no |
| <a name="input_proxy_configuration"></a> [proxy\_configuration](#input\_proxy\_configuration) | (Optional) The proxy configuration details for the App Mesh proxy. This is a list of maps, where each map should contain "container\_name", "properties" and "type" | `list(any)` | `[]` | no |
| <a name="input_repository_credentials"></a> [repository\_credentials](#input\_repository\_credentials) | name or ARN of a secrets manager secret (arn:aws:secretsmanager:region:aws\_account\_id:secret:secret\_name) | `string` | `""` | no |
| <a name="input_repository_credentials_kms_key"></a> [repository\_credentials\_kms\_key](#input\_repository\_credentials\_kms\_key) | key id, key ARN, alias name or alias ARN of the key that encrypted the repository credentials | `string` | `"alias/aws/secretsmanager"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (key-value pairs) passed to resources. | `map(string)` | `{}` | no |
| <a name="input_task_container_command"></a> [task\_container\_command](#input\_task\_container\_command) | The command that is passed to the container. | `list(string)` | `[]` | no |
| <a name="input_task_container_cpu"></a> [task\_container\_cpu](#input\_task\_container\_cpu) | Amount of CPU to reserve for the container. | `number` | `null` | no |
| <a name="input_task_container_environment"></a> [task\_container\_environment](#input\_task\_container\_environment) | The environment variables to pass to a container. | `map(string)` | `{}` | no |
| <a name="input_task_container_image"></a> [task\_container\_image](#input\_task\_container\_image) | The image used to start a container. | `string` | n/a | yes |
| <a name="input_task_container_memory"></a> [task\_container\_memory](#input\_task\_container\_memory) | The hard limit (in MiB) of memory for the container. | `number` | `null` | no |
| <a name="input_task_container_memory_reservation"></a> [task\_container\_memory\_reservation](#input\_task\_container\_memory\_reservation) | The soft limit (in MiB) of memory to reserve for the container. | `number` | `null` | no |
| <a name="input_task_container_port"></a> [task\_container\_port](#input\_task\_container\_port) | The port number on the container that is bound to the user-specified or automatically assigned host port | `number` | `0` | no |
| <a name="input_task_container_secrets"></a> [task\_container\_secrets](#input\_task\_container\_secrets) | The secrets variables to pass to a container. | `list(map(string))` | `null` | no |
| <a name="input_task_container_working_directory"></a> [task\_container\_working\_directory](#input\_task\_container\_working\_directory) | The working directory to run commands inside the container. | `string` | `""` | no |
| <a name="input_task_definition_cpu"></a> [task\_definition\_cpu](#input\_task\_definition\_cpu) | Amount of CPU to reserve for the task. | `number` | `256` | no |
| <a name="input_task_definition_memory"></a> [task\_definition\_memory](#input\_task\_definition\_memory) | The soft limit (in MiB) of memory to reserve for the task. | `number` | `512` | no |
| <a name="input_task_health_check"></a> [task\_health\_check](#input\_task\_health\_check) | An optional healthcheck definition for the task | `object({ command = list(string), interval = number, timeout = number, retries = number, startPeriod = number })` | `null` | no |
| <a name="input_task_host_port"></a> [task\_host\_port](#input\_task\_host\_port) | The port number on the container instance to reserve for your container. | `number` | `0` | no |
| <a name="input_task_mount_points"></a> [task\_mount\_points](#input\_task\_mount\_points) | The mount points for data volumes in your container. Each object inside the list requires "sourceVolume", "containerPath" and "readOnly". For more information see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html | `list(object({ sourceVolume = string, containerPath = string, readOnly = bool }))` | `null` | no |
| <a name="input_task_start_timeout"></a> [task\_start\_timeout](#input\_task\_start\_timeout) | Time duration (in seconds) to wait before giving up on resolving dependencies for a container. If this parameter is not specified, the default value of 3 minutes is used (fargate). | `number` | `null` | no |
| <a name="input_task_stop_timeout"></a> [task\_stop\_timeout](#input\_task\_stop\_timeout) | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own. The max stop timeout value is 120 seconds and if the parameter is not specified, the default value of 30 seconds is used. | `number` | `null` | no |
| <a name="input_volume"></a> [volume](#input\_volume) | (Optional) A set of volume blocks that containers in your task may use. This is a list of maps, where each map should contain "name", "host\_path", "docker\_volume\_configuration" and "efs\_volume\_configuration". Full set of options can be found at https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_port"></a> [container\_port](#output\_container\_port) | Port on which the container is listening. |
| <a name="output_execution_role_arn"></a> [execution\_role\_arn](#output\_execution\_role\_arn) | The Amazon Resource Name (ARN) of execution role. |
| <a name="output_execution_role_create_date"></a> [execution\_role\_create\_date](#output\_execution\_role\_create\_date) | The creation date of the IAM role. |
| <a name="output_execution_role_id"></a> [execution\_role\_id](#output\_execution\_role\_id) | The ID of the execution role. |
| <a name="output_execution_role_name"></a> [execution\_role\_name](#output\_execution\_role\_name) | The name of the execution service role. |
| <a name="output_execution_role_unique_id"></a> [execution\_role\_unique\_id](#output\_execution\_role\_unique\_id) | The stable and unique string identifying the role. |
| <a name="output_task_definition_arn"></a> [task\_definition\_arn](#output\_task\_definition\_arn) | Full ARN of the Task Definition (including both family and revision). |
| <a name="output_task_definition_family"></a> [task\_definition\_family](#output\_task\_definition\_family) | The family of the Task Definition. |
| <a name="output_task_definition_revision"></a> [task\_definition\_revision](#output\_task\_definition\_revision) | The revision of the task in a particular family. |
| <a name="output_task_role_arn"></a> [task\_role\_arn](#output\_task\_role\_arn) | The Amazon Resource Name (ARN) specifying the ECS service role. |
| <a name="output_task_role_create_date"></a> [task\_role\_create\_date](#output\_task\_role\_create\_date) | The creation date of the IAM role. |
| <a name="output_task_role_id"></a> [task\_role\_id](#output\_task\_role\_id) | The ID of the role. |
| <a name="output_task_role_name"></a> [task\_role\_name](#output\_task\_role\_name) | The name of the Fargate task service role. |
| <a name="output_task_role_unique_id"></a> [task\_role\_unique\_id](#output\_task\_role\_unique\_id) | The stable and unique string identifying the role. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

See LICENSE for full details.

## Pre-commit hooks

### Install dependencies

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/segmentio/terraform-docs) required for `terraform_docs` hooks.
* [`TFLint`](https://github.com/terraform-linters/tflint) required for `terraform_tflint` hook.

#### MacOS

```bash
brew install pre-commit terraform-docs tflint

brew tap git-chglog/git-chglog
brew install git-chglog
```
