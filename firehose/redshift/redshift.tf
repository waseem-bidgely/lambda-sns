provider "aws" {
}
resource "aws_kinesis_firehose_delivery_stream" "test_stream" {
  name        = var.name
  destination = "redshift"

  s3_configuration {
    role_arn        = "arn:aws:iam::076900401824:role/firehose_delivery_role"
    bucket_arn      = "arn:aws:s3:::common-metrics-prod-ca"
    buffer_size     = 5
    buffer_interval = 300
    prefix          = var.prefix/
  }

  redshift_configuration {
    role_arn        = "arn:aws:iam::076900401824:role/firehose_delivery_role"
    cluster_jdbcurl = "jdbc:redshift://canada-prodca-redshiftcluster.cdozp90tzpyi.ca-central-1.redshift.amazonaws.com:5439/bdw"
    username        = "badm"
    password        = var.password
    data_table_name = var.name
    copy_options    = "TIMEFORMAT AS 'epochmillisecs' json 'auto'"
    s3_backup_mode  = "Disabled"
  }
}
