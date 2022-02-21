provider "aws" {
  region = "us-west-2"

}

resource "aws_ecs_task_definition" "airflow-tf" {
  family                = "airflow-tf"
  container_definitions = <<DEFINITION
 [
   {
     "name": "airflow",
     "image": "${var.account}.dkr.ecr.${var.region}.amazonaws.com/${var.image}",
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
          "image": "${var.account}.dkr.ecr.${var.region}.amazonaws.com/bidgely-airflow:rabbitmq",
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
resource "aws_ecs_task_definition" "airflow-worker-tf" {
  family                   = "airflow-worker-tf"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "worker",
      "image": "${var.account}.dkr.ecr.${var.region}.amazonaws.com/${var.image}",
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
       },
       {
         "name": "AIRFLOW__API__AUTH_BACKEND",
         "value": "${var.AIRFLOW__API__AUTH_BACKEND}"
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

resource "aws_alb" "application_load_balancer" {
  name               = "airflow-${var.BIDGELY_ENV}-test"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_security_group.id]
  subnets            = var.subnet

  enable_deletion_protection = false

}
resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = var.vpc

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["106.51.85.84/32", "14.99.1.234/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_lb_target_group" "target_group" {
  name        = "airflow-${var.BIDGELY_ENV}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc

  health_check {
    healthy_threshold   = "5"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "302"
    timeout             = "5"
    path                = "/"
    unhealthy_threshold = "2"
  }
}
resource "aws_lb_listener" "listener-https" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "80"
  protocol          = "HTTP"


  default_action {
    target_group_arn = aws_lb_target_group.target_group.id
    type             = "forward"
  }
}
resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "airflow-${var.BIDGELY_ENV}-cluster"
}
resource "aws_autoscaling_group" "ecs-cluster" {
  name                 = var.asg_name
  min_size             = "2"
  max_size             = "2"
  desired_capacity     = "2"
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.instance.name
  vpc_zone_identifier  = [var.vpc_zone_identifier]
}
data "aws_vpc" "selected" {
  id = var.vpc_id
}
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    description = "all from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_launch_configuration" "instance" {
  name                        = var.launch_configuration
  image_id                    = var.ami
  instance_type               = var.instance_type
  iam_instance_profile        = var.iam_instance_profile
  security_groups             = [aws_security_group.allow_all.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  user_data                   = <<EOF
#!/bin/bash
echo ECS_CLUSTER=airflow-${var.BIDGELY_ENV}-cluster >> /etc/ecs/ecs.config
EOF




  root_block_device {
    volume_size = "30"
    volume_type = "gp2"
  }
}
data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.airflow-tf.family
}
resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "master"
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = "${aws_ecs_task_definition.airflow-tf.family}:${max(aws_ecs_task_definition.airflow-tf.revision, data.aws_ecs_task_definition.main.revision)}"
  launch_type          = "EC2"
  scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true
  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  network_configuration {
    subnets          = ["subnet-63443d05"]
    assign_public_ip = false
    security_groups  = ["sg-0734172aa5832406d"]
  }
  health_check_grace_period_seconds = 2147483647

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "airflow"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.listener-https]
  service_registries {
    registry_arn = aws_service_discovery_service.airflow-master.arn
  }

}

resource "aws_service_discovery_private_dns_namespace" "airflow-master" {
  name        = "airflow-master"
  description = "example"
  vpc         = var.vpc
}

resource "aws_service_discovery_service" "airflow-master" {
  name = "airflow-master"

  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.airflow-master.id
    routing_policy = "MULTIVALUE"

    dns_records {
      ttl  = 60
      type = "A"
    }


  }
}
data "aws_ecs_task_definition" "worker" {
  task_definition = aws_ecs_task_definition.airflow-worker-tf.family
}


resource "aws_ecs_service" "aws-ecs-worker" {
  name                 = "worker"
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = "${aws_ecs_task_definition.airflow-worker-tf.family}:${max(aws_ecs_task_definition.airflow-worker-tf.revision, data.aws_ecs_task_definition.worker.revision)}"
  launch_type          = "EC2"
  scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true
  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  network_configuration {
    subnets          = ["subnet-63443d05"]
    assign_public_ip = false
    security_groups  = ["sg-0734172aa5832406d"]
  }

  service_registries {
    registry_arn = aws_service_discovery_service.airflow-worker.arn
  }

}


resource "aws_service_discovery_private_dns_namespace" "airflow-worker" {
  name        = "airflow-worker-qa"
  description = "example"
  vpc         = var.vpc
}

resource "aws_service_discovery_service" "airflow-worker" {
  name = "airflow-worker-qa"

  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.airflow-worker.id
    routing_policy = "MULTIVALUE"

    dns_records {
      ttl  = 60
      type = "A"
    }


  }
}
