provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/home/rahul-optit/.aws/credentials"
  profile                 = "na"
}
resource "aws_launch_template" "parquettoolslaunchtemplate" {
  name = "parquettoolslaunchtemplatetf"
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 500
      volume_type = "gp2"
    }
  }
  iam_instance_profile {
    name = "${local.instance_profile}"
  }
  image_id = "${local.image}"
  key_name = "${local.key_name}"

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = "${local.subnet_id}"
    security_groups             = ["sg-7cefc601"]
  }

  placement {
    availability_zone = "${local.availability_zone}"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "parquettools"
    }
  }
}
resource "aws_spot_fleet_request" "cheap_compute" {
  iam_fleet_role      = "arn:aws:iam::857283459404:role/aws-ec2-spot-fleet-tagging-role"
  spot_price          = "0.03"
  allocation_strategy = "lowestPrice"
  target_capacity     = 1
  valid_until         = "2023-11-04T20:44:20Z"

  launch_specification {
    instance_type        = "m4.10xlarge"
    ami                  = "${local.image}"
    spot_price           = "0.366"
    key_name             = "${local.key_name}"
    iam_instance_profile = "${local.instance_profile}"
    availability_zone    = "${local.availability_zone}"
    subnet_id            = "${local.subnet_id}"
    placement_tenancy    = "default"
    user_data            = "${base64encode(file("parq.sh"))}"
  }
  launch_specification {
    instance_type        = "m4.xlarge"
    ami                  = "${local.image}"
    spot_price           = "0.366"
    key_name             = "${local.key_name}"
    iam_instance_profile = "${local.instance_profile}"
    availability_zone    = "${local.availability_zone}"
    subnet_id            = "${local.subnet_id}"
    placement_tenancy    = "default"
    user_data            = "${base64encode(file("parq.sh"))}"
  }
  launch_specification {
    instance_type        = "m4.2xlarge"
    ami                  = "${local.image}"
    spot_price           = "0.366"
    key_name             = "${local.key_name}"
    iam_instance_profile = "${local.instance_profile}"
    availability_zone    = "${local.availability_zone}"
    subnet_id            = "${local.subnet_id}"
    placement_tenancy    = "default"
    user_data            = "${base64encode(file("parq.sh"))}"
  }
  launch_specification {
    instance_type        = "m4.4xlarge"
    ami                  = "${local.image}"
    spot_price           = "0.366"
    key_name             = "${local.key_name}"
    iam_instance_profile = "${local.instance_profile}"
    availability_zone    = "${local.availability_zone}"
    subnet_id            = "${local.subnet_id}"
    placement_tenancy    = "default"
    user_data            = "${base64encode(file("parq.sh"))}"

    tags = {
      Name = "parquettools"
    }
  }
}
