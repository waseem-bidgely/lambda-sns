provider "aws" {
  region = "us-west-2"

}

resource "aws_ecs_task_definition" "airflow-tf" {
  family                = "airflow-tf"
  container_definitions = <<DEFINITION
 [
   {
     "name": "airflow",
     "image": "189675173661.dkr.ecr.us-west-2.amazonaws.com/bidgely-airflow:0.11",
     "cpu": 1,
     "memory": 2048,
     "entrypoint": ["bash", "-c"],
     "command": ["/bin/bash -c '/opt/run-master.sh'"],
     "workingDirectory": "/root/airflow",
     "essential": true,
     "environment": [
       {
         "name": "AIRFLOW__CELERY__BROKER_URL",
         "value": "${var.AIRFLOW__CELERY__BROKER_URL}"
       },
       {
         "name": "AIRFLOW__CELERY__FLOWER_HOST",
         "value": "${var.AIRFLOW__CELERY__FLOWER_HOST}"
       },
       {
         "name": "AIRFLOW__CELERY__RESULT_BACKEND",
         "value": "${var.AIRFLOW__CELERY__RESULT_BACKEND}"
       },
       {
         "name": "AIRFLOW__CORE__DAG_RUN_CONF_OVERRIDES_PARAMS",
         "value": "${var.AIRFLOW__CORE__DAG_RUN_CONF_OVERRIDES_PARAMS}"
       },
       {
         "name": "AIRFLOW__CORE__EXECUTOR",
         "value": "${var.AIRFLOW__CORE__EXECUTOR}"
       },
       {
         "name": "AIRFLOW__CORE__FERNET_KEY",
         "value": "${var.AIRFLOW__CORE__FERNET_KEY}"
       },
       {
         "name": "AIRFLOW__CORE__LOAD_EXAMPLES",
         "value": "${var.AIRFLOW__CORE__LOAD_EXAMPLES}"
       },
       {
         "name": "AIRFLOW__CORE__REMOTE_BASE_LOG_FOLDER",
         "value": "${var.AIRFLOW__CORE__REMOTE_BASE_LOG_FOLDER}"
       },
       {
         "name": "AIRFLOW__CORE__REMOTE_LOGGING",
         "value": "${var.AIRFLOW__CORE__REMOTE_LOGGING}"
       },
       {
         "name": "AIRFLOW__CORE__SQL_ALCHEMY_CONN",
         "value": "${var.AIRFLOW__CORE__SQL_ALCHEMY_CONN}"
       },
       {
         "name": "AIRFLOW__OPERATORS__DEFAULT_OWNER",
         "value": "${var.AIRFLOW__OPERATORS__DEFAULT_OWNER}"
       },
       {
         "name": "AIRFLOW__WEBSERVER__AUTH_BACKEND",
         "value": "${var.AIRFLOW__WEBSERVER__AUTH_BACKEND}"
       },
       {
         "name": "AIRFLOW__WEBSERVER__AUTHENTICATE",
         "value": "${var.AIRFLOW__WEBSERVER__AUTHENTICATE}"
       },
       {
         "name": "AIRFLOW__WEBSERVER__RBAC",
         "value": "${var.AIRFLOW__WEBSERVER__RBAC}"
       },
       {
         "name": "AWS_DEFAULT_REGION",
       "value": "${var.AWS_DEFAULT_REGION}"
       },
       {
         "name": "BIDGELY_ENV",
         "value": "${var.BIDGELY_ENV}"
       },
       {
         "name": "AIRFLOW__API__AUTH_BACKEND",
         "value": "${var.AIRFLOW__API__AUTH_BACKEND}"
       }
       
     ],
     "portMappings": [
       {
         "containerPort": 8080,
         "hostPort": 8080
       },
       {
         "containerPort": 5555,
          "hostPort": 5555
       }
     ]
        },
        {
          "name": "rabbitmq",
          "image": "189675173661.dkr.ecr.us-west-2.amazonaws.com/bidgely-airflow:rabbitmq",
          "entrypoint": ["bash", "-c"],
          "command": ["bash -c '/run/run.sh'"],
          "memory": 1024,
          "cpu": 1,
          "essential": true,
          "portMappings": [
            {
              "containerPort": 5672,
              "hostPort": 5672
            },
            {
              "containerPort": 15672,
              "hostPort": 15672
            }
          ]
          
        }
 ]

DEFINITION

  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "2048"
  task_role_arn            = var.ecs_role
  execution_role_arn       = var.ecs_role
}
resource "aws_ecs_task_definition" "airflow-worker" {
  family                   = "airflow-worker"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "worker",
      "image": "189675173661.dkr.ecr.us-west-2.amazonaws.com/bidgely-airflow:0.11",
     "cpu": 1,
     "memory": 2048,
     "entrypoint": ["bash", "-c"],
     "command": ["/bin/bash -c '/opt/run-worker.sh'"],
     "workingDirectory": "/root/airflow",
     "essential": true,
     "environment": [
       {
         "name": "AIRFLOW__CELERY__BROKER_URL",
         "value": "${var.AIRFLOW__CELERY__BROKER_URL}"
       },
       {
         "name": "AIRFLOW__CELERY__FLOWER_HOST",
         "value": "${var.AIRFLOW__CELERY__FLOWER_HOST}"
       },
       {
         "name": "AIRFLOW__CELERY__RESULT_BACKEND",
         "value": "${var.AIRFLOW__CELERY__RESULT_BACKEND}"
       },
       {
         "name": "AIRFLOW__CORE__DAG_RUN_CONF_OVERRIDES_PARAMS",
         "value": "${var.AIRFLOW__CORE__DAG_RUN_CONF_OVERRIDES_PARAMS}"
       },
       {
         "name": "AIRFLOW__CORE__EXECUTOR",
         "value": "${var.AIRFLOW__CORE__EXECUTOR}"
       },
       {
         "name": "AIRFLOW__CORE__FERNET_KEY",
         "value": "${var.AIRFLOW__CORE__FERNET_KEY}"
       },
       {
         "name": "AIRFLOW__CORE__LOAD_EXAMPLES",
         "value": "${var.AIRFLOW__CORE__LOAD_EXAMPLES}"
       },
       {
         "name": "AIRFLOW__CORE__REMOTE_BASE_LOG_FOLDER",
         "value": "${var.AIRFLOW__CORE__REMOTE_BASE_LOG_FOLDER}"
       },
       {
         "name": "AIRFLOW__CORE__REMOTE_LOGGING",
         "value": "${var.AIRFLOW__CORE__REMOTE_LOGGING}"
       },
       {
         "name": "AIRFLOW__CORE__SQL_ALCHEMY_CONN",
         "value": "${var.AIRFLOW__CORE__SQL_ALCHEMY_CONN}"
       },
       {
         "name": "AIRFLOW__OPERATORS__DEFAULT_OWNER",
         "value": "${var.AIRFLOW__OPERATORS__DEFAULT_OWNER}"
       },
       {
         "name": "AIRFLOW__WEBSERVER__AUTH_BACKEND",
         "value": "${var.AIRFLOW__WEBSERVER__AUTH_BACKEND}"
       },
       {
         "name": "AIRFLOW__WEBSERVER__AUTHENTICATE",
         "value": "${var.AIRFLOW__WEBSERVER__AUTHENTICATE}"
       },
       {
         "name": "AIRFLOW__WEBSERVER__RBAC",
         "value": "${var.AIRFLOW__WEBSERVER__RBAC}"
       },
       {
         "name": "AWS_DEFAULT_REGION",
       "value": "${var.AWS_DEFAULT_REGION}"
       },
       {
         "name": "BIDGELY_ENV",
         "value": "${var.BIDGELY_ENV}"
       }
     ],
     "portMappings": [
       {
         "containerPort": 8793,
         "hostPort": 8793
       }
     ]
    }
  ]
  DEFINITION
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "2048"
  task_role_arn            = var.ecs_role
  execution_role_arn       = var.ecs_role
}


