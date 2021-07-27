provider "aws" {
  region = "ca-central-1"
}
resource "aws_kinesis_firehose_delivery_stream" "test_stream" {
  name        = "hourly_water_data_prod-ca"
  destination = "redshift"

  s3_configuration {
    role_arn        = "arn:aws:iam::076900401824:role/firehose_delivery_role"
    bucket_arn      = "arn:aws:s3:::common-metrics-prod-ca"
    buffer_size     = 5
    buffer_interval = 300
    prefix          = "hourly_water_data_firehose/"
  }

  redshift_configuration {
    role_arn        = "arn:aws:iam::076900401824:role/firehose_delivery_role"
    cluster_jdbcurl = "jdbc:redshift://canada-prodca-redshiftcluster.cdozp90tzpyi.ca-central-1.redshift.amazonaws.com:5439/bdw"
    username        = "badm"
    password        = "password"
    data_table_name = "hourly_water_data_firehose"
    copy_options    = "TIMEFORMAT AS 'epochmillisecs' json 'auto'"
    s3_backup_mode  = "Disabled"
  }
}
