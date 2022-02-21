variable "ecs_role" {
  type = string
}
variable "AIRFLOW__CELERY__BROKER_URL" {
  type = string
}
variable "AIRFLOW__CELERY__FLOWER_HOST" {
  type = string

}
variable "AIRFLOW__CELERY__RESULT_BACKEND" {
  type = string
}
variable "AIRFLOW__CORE__DAG_RUN_CONF_OVERRIDES_PARAMS" {
  type = string

}
variable "AIRFLOW__CORE__EXECUTOR" {
  type = string
}
variable "AIRFLOW__CORE__FERNET_KEY" {
  type = string

}
variable "AIRFLOW__CORE__LOAD_EXAMPLES" {
  type = string
}
variable "AIRFLOW__CORE__REMOTE_BASE_LOG_FOLDER" {
  type = string
}
variable "AIRFLOW__CORE__REMOTE_LOGGING" {
  type = string

}
variable "AIRFLOW__CORE__SQL_ALCHEMY_CONN" {
  type = string
}
variable "AIRFLOW__OPERATORS__DEFAULT_OWNER" {
  type = string
}
variable "AIRFLOW__WEBSERVER__AUTH_BACKEND" {
  type = string
}
variable "AIRFLOW__WEBSERVER__AUTHENTICATE" {
  type = string

}
variable "AIRFLOW__WEBSERVER__RBAC" {
  type = string
}
variable "AWS_DEFAULT_REGION" {
  type = string

}
variable "BIDGELY_ENV" {
  type = string
}
variable "AIRFLOW__API__AUTH_BACKEND" {
  type = string

}
variable "account" {
  type = string

}
variable "region" {
  type = string

}
variable "image" {
  type = string
}
variable "subnet" {
  type = list(any)
}
variable "vpc" {
  type = string

}
variable "vpc_id" {
  type = string

}

variable "cluster_name" {
  type = string

}
variable "asg_name" {
  type = string

}
variable "vpc_zone_identifier" {
  type = string

}
variable "launch_configuration" {
  type = string

}
variable "ami" {
  type = string

}
variable "instance_type" {
  type = string

}
variable "iam_instance_profile" {
  type = string

}
variable "key_name" {
  type = string

}
