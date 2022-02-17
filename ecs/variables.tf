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