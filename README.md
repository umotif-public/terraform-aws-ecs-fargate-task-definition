# terraform-aws-ecs-fargate-task-definition
Terraform module to create AWS ECS Fargate Task Definition.

## Terraform versions

Terraform 0.12. Pin module version to `~> v1.0`. Submit pull-requests to `master` branch.

## Usage

```hcl
module "ecs-task-definition" {
  source = "umotif-public/ecs-fargate-task-definition/aws"
  version = "~> 1.0"

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

## Authors

Module managed by [Marcin Cuber](https://github.com/marcincuber) [LinkedIn](https://www.linkedin.com/in/marcincuber/).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cloudwatch\_log\_group\_name | CloudWatch log group name required to enabled logDriver in container definitions for ecs task. | string | `""` | no |
| container\_name | Optional name for the container to be used instead of name\_prefix. | string | `""` | no |
| docker\_volume\_configuration | \(Optional\) Used to configure a docker volume option "docker\_volume\_configuration". Full set of options can be found at https://www.terraform.io/docs/providers/aws/r/ecs\_task\_definition.html | list | `[]` | no |
| enabled | Whether to create the resources. Set to `false` to prevent the module from creating any resources | bool | `"true"` | no |
| name\_prefix | A prefix used for naming resources. | string | n/a | yes |
| placement\_constraints | \(Optional\) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10. This is a list of maps, where each map should contain "type" and "expression" | list | `[]` | no |
| proxy\_configuration | \(Optional\) The proxy configuration details for the App Mesh proxy. This is a list of maps, where each map should contain "container\_name", "properties" and "type" | list | `[]` | no |
| repository\_credentials | name or ARN of a secrets manager secret \(arn:aws:secretsmanager:region:aws\_account\_id:secret:secret\_name\) | string | `""` | no |
| repository\_credentials\_kms\_key | key id, key ARN, alias name or alias ARN of the key that encrypted the repository credentials | string | `"alias/aws/secretsmanager"` | no |
| tags | A map of tags \(key-value pairs\) passed to resources. | map(string) | `{}` | no |
| task\_container\_command | The command that is passed to the container. | list(string) | `[]` | no |
| task\_container\_environment | The environment variables to pass to a container. | map(string) | `{}` | no |
| task\_container\_image | The image used to start a container. | string | n/a | yes |
| task\_container\_port | The port number on the container that is bound to the user-specified or automatically assigned host port | number | n/a | yes |
| task\_definition\_cpu | Amount of CPU to reserve for the task. | number | `"256"` | no |
| task\_definition\_memory | The soft limit \(in MiB\) of memory to reserve for the container. | number | `"512"` | no |
| task\_host\_port | The port number on the container instance to reserve for your container. | number | `"0"` | no |
| volume | \(Optional\) A set of volume blocks that containers in your task may use. This is a list of maps, where each map should contain "name", "host\_path" and "docker\_volume\_configuration". Full set of options can be found at https://www.terraform.io/docs/providers/aws/r/ecs\_task\_definition.html | list | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| container\_port | Port on which the container is listening. |
| execution\_role\_arn | The Amazon Resource Name \(ARN\) of execution role. |
| execution\_role\_create\_date | The creation date of the IAM role. |
| execution\_role\_id | The ID of the execution role. |
| execution\_role\_name | The name of the execution service role. |
| execution\_role\_unique\_id | The stable and unique string identifying the role. |
| task\_definition\_arn | Full ARN of the Task Definition \(including both family and revision\). |
| task\_definition\_family | The family of the Task Definition. |
| task\_definition\_revision | The revision of the task in a particular family. |
| task\_role\_arn | The Amazon Resource Name \(ARN\) specifying the ECS service role. |
| task\_role\_create\_date | The creation date of the IAM role. |
| task\_role\_id | The ID of the role. |
| task\_role\_name | The name of the Fargate task service role. |
| task\_role\_unique\_id | The stable and unique string identifying the role. |

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
```