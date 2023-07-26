resource "aws_efs_file_system" "efs" {
  creation_token = "efs-html"

  tags = {
    Name = "efs-html"
  }
}

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

  task_definition_cpu    = "512"
  task_definition_memory = "1024"

  task_container_environment = {
    "ENVIRONEMNT" = "Test"
  }

  cloudwatch_log_group_name = "/test-cloudwatch/log-group"
  task_container_command    = ["/bin/sh -c \"echo '<html> <head> <title>Amazon ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Amazon ECS Sample App</h1> <h2>Congratulations!</h2> <p>Your application is now running on a container in Amazon ECS.</p> </div></body></html>' > /usr/local/apache2/htdocs/index.html && httpd-foreground\""]

  task_stop_timeout = 90

  task_mount_points = [
    {
      "sourceVolume"  = aws_efs_file_system.efs.creation_token,
      "containerPath" = "/usr/share/nginx/html",
      "readOnly"      = true
    }
  ]

  volume = [
    {
      name = "efs-html",
      efs_volume_configuration = [
        {
          "file_system_id" : aws_efs_file_system.efs.id,
          "root_directory" : "/usr/share/nginx"
        }
      ]
    }
  ]
}
