provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "/home/rahul-optit/.aws/credentials"
  profile                 = "nonprodqa"
}
resource "aws_ecs_task_definition" "airflow-tf" {
  family = "airflow-tf"
  container_definitions = jsonencode([
    {
      "name"             = "airflow"
      "image"            = "189675173661.dkr.ecr.us-west-2.amazonaws.com/bidgely-airflow:0.11"
      cpu                = 1
      "memory"           = 2048
      "entrypoint"       = ["bash", "-c"]
      "command"          = ["/bin/bash -c '/opt/run-master.sh'"]
      "workingDirectory" = "/opt/airflow"
      "essential"        = true
      "environment"      = var.my_env_variables
      "portMappings" = [
        {
          containerPort = 8080
          hostPort      = 8080
        },
        {
          containerPort : 5555
          hostPort : 5555
        }
      ]
    },
    {
      "name"       = "rabbitmq"
      "image"      = "189675173661.dkr.ecr.us-west-2.amazonaws.com/bidgely-airflow:rabbitmq"
      "entrypoint" = ["bash", "-c"]
      "command"    = ["bash -c '/run/run.sh'"]
      "memory"     = 1024
      "essential"  = true
      "cpu"        = 1
      "portMappings" = [
        {
          containerPort : 5672
          hostPort : 5672
        },
        {
          containerPort : 15672
          hostPort : 15672
        }
      ]
    }
  ])
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "2048"
  task_role_arn            = var.ecs_role
  execution_role_arn       = var.ecs_role
}