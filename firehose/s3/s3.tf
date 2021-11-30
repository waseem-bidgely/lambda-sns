resource "aws_kinesis_firehose_delivery_stream" "test_s3_stream" {
  name        = var.name
  destination = "s3"

  s3_configuration {
    role_arn        = "arn:aws:iam::076900401824:role/firehose_delivery_role"
    bucket_arn      = "arn:aws:s3:::common-metrics-prod-ca"
    buffer_size     = 100
    buffer_interval = 60
    prefix          = var.prefix
  }
}
