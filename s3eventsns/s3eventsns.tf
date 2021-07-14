provider "aws" {
  region                  = "us-west-2"
}
resource "aws_sns_topic" "topic" {
  name = "s3-event-notification-topic"

resource "aws_s3_bucket" "bucket" {
  bucket = "var.bucket"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  topic {
    topic_arn     = var.topic_arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = "var.filter_suffix"
  }
}
