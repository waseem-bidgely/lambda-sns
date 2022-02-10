variable "ecs_role" {
  type = string
}
variable "my_env_variables" {
  default = [
    {
      "name" : "AIRFLOW__CELERY__BROKER_URL",
      "value" : "test"
    },
    {
      "name" : "AIRFLOW__CELERY__FLOWER_HOST",
      "value" : "airflow-master.airflow-dev-ha"
    },
    {
      "name" : "AIRFLOW__CELERY__RESULT_BACKEND",
      "value" : "db+mysql://test:test@dev-rds.cmlamxremgnb.us-west-2.rds.amazonaws.com:3306/airflowv2"
    },
    {
      "name" : "AIRFLOW__CORE__DAG_RUN_CONF_OVERRIDES_PARAMS",
      "value" : "True"
    },
    {
      "name" : "AIRFLOW__CORE__EXECUTOR",
      "value" : "CeleryExecutor"
    },
    {
      "name" : "AIRFLOW__CORE__FERNET_KEY",
      "value" : "N2OLrTTabULw8tWddt3K4A6Z-BYYPSfA7PU-lsXKG6s="
    },
    {
      "name" : "AIRFLOW__CORE__LOAD_EXAMPLES",
      "value" : "False"
    },
    {
      "name" : "AIRFLOW__CORE__REMOTE_BASE_LOG_FOLDER",
      "value" : "s3://bidgely-log-backup/airflow/logs"
    },
    {
      "name" : "AIRFLOW__CORE__REMOTE_LOGGING",
      "value" : "true"
    },
    {
      "name" : "AIRFLOW__CORE__SQL_ALCHEMY_CONN",
      "value" : "mysql://test:test@dev-rds.cmlamxremgnb.us-west-2.rds.amazonaws.com:3306/airflowv2"
    },
    {
      "name" : "AIRFLOW__OPERATORS__DEFAULT_OWNER",
      "value" : "bidgely"
    },
    {
      "name" : "AIRFLOW__WEBSERVER__AUTH_BACKEND",
      "value" : "airflow.contrib.auth.backends.password_auth"
    },
    {
      "name" : "AIRFLOW__WEBSERVER__AUTHENTICATE",
      "value" : "True"
    },
    {
      "name" : "AIRFLOW__WEBSERVER__RBAC",
      "value" : "True"
    },
    {
      "name" : "AWS_DEFAULT_REGION",
      "value" : "us-west-2"
    },
    {
      "name" : "BIDGELY_ENV",
      "value" : "dev"
    }
  ]
}