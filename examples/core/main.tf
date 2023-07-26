#####
# Optional Secret creation for task credentials
#####

# data "aws_kms_key" "secretsmanager_key" {
#   key_id = "alias/aws/secretsmanager"
# }


# resource "aws_secretsmanager_secret" "task_credentials" {
#   name = "task_repository_credentials"

#   kms_key_id = data.aws_kms_key.secretsmanager_key.arn
# }

#####
# task definition
#####
module "ecs-task-definition" {
  source = "../.."

  enabled              = true
  name_prefix          = "test-container"
  task_container_image = "httpd:2.4"

  container_name      = "test-container-name"
  task_container_port = "80"
  task_host_port      = "80"

  task_definition_cpu    = "256"
  task_definition_memory = "512"

  task_container_environment = {
    "ENVIRONEMNT" = "Test"
  }

  cloudwatch_log_group_name = "/test-cloudwatch/log-group"
  task_container_command    = ["/bin/sh -c \"echo '<html> <head> <title>Amazon ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Amazon ECS Sample App</h1> <h2>Congratulations!</h2> <p>Your application is now running on a container in Amazon ECS.</p> </div></body></html>' > /usr/local/apache2/htdocs/index.html && httpd-foreground\""]

  task_stop_timeout = 90

  ### uncomment the following lines to use private repository credentials
  # create_repository_credentials_iam_policy = true
  # repository_credentials                   = aws_secretsmanager_secret.task_credentials.arn # also set create_repository_credentials_iam_policy = true
}

