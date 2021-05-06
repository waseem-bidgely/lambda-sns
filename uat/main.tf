provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "/home/rahul-optit/.aws/credentials"
  profile                 = "nonprodqa"
}

resource "aws_launch_template" "aggregationServicesuatspot" {
  name = "aggregationServicesuatspot"
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 30
      volume_type = "gp2"

    }
  }
  iam_instance_profile {
    name = "uat-iam-instance-profile"
  }

  image_id = "ami-6672ff1e"
  key_name = "uat"

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = "subnet-726ea80b"
    security_groups             = ["sg-08039c77"]

  }

  placement {
    availability_zone = "us-west-2a"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "daemons-avista"
    }
  }
}
resource "aws_spot_fleet_request" "cheap_compute" {
  iam_fleet_role      = "arn:aws:iam::189675173661:role/aws-ec2-spot-fleet-tagging-role"
  spot_price          = "0.03"
  allocation_strategy = "lowestPrice"
  target_capacity     = 1
  valid_until         = "2023-11-04T20:44:20Z"


  launch_specification {
    instance_type          = "m4.10xlarge"
    ami                    = "ami-6672ff1e"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("ingester.sh"))}"

  }
  launch_specification {
    instance_type          = "m4.xlarge"
    ami                    = "ami-6672ff1e"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("ingester.sh"))}"

  }
  launch_specification {
    instance_type          = "m4.2xlarge"
    ami                    = "ami-6672ff1e"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("ingester.sh"))}"

  }

  launch_specification {
    instance_type          = "m4.4xlarge"
    ami                    = "ami-6672ff1e"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("ingester.sh"))}"

    tags = {
      Name = "aggregations"
    }
  }
}
resource "aws_launch_template" "ingesteruatspot" {
  name = "ingesteruatspot"
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 30
      volume_type = "gp2"

    }
  }
  iam_instance_profile {
    name = "uat-iam-instance-profile"
  }

  image_id = "ami-6672ff1e"
  key_name = "uat"

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = "subnet-726ea80b"
    security_groups             = ["sg-08039c77"]

  }

  placement {
    availability_zone = "us-west-2a"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "daemons-avista"
    }
  }
}
resource "aws_spot_fleet_request" "cheap_compute_agg" {
  iam_fleet_role      = "arn:aws:iam::189675173661:role/aws-ec2-spot-fleet-tagging-role"
  spot_price          = "0.03"
  allocation_strategy = "lowestPrice"
  target_capacity     = 1
  valid_until         = "2023-11-04T20:44:20Z"


  launch_specification {
    instance_type          = "m4.10xlarge"
    ami                    = "ami-6672ff1e"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("aggregationsud.sh"))}"

  }
  launch_specification {
    instance_type          = "m4.xlarge"
    ami                    = "ami-6672ff1e"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("aggregationsud.sh"))}"

  }
  launch_specification {
    instance_type          = "m4.2xlarge"
    ami                    = "ami-6672ff1e"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("aggregationsud.sh"))}"

  }

  launch_specification {
    instance_type          = "m4.4xlarge"
    ami                    = "ami-6672ff1e"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("aggregationsud.sh"))}"

    tags = {
      Name = "aggregations"
    }
  }
}
resource "aws_launch_template" "disagguatspot" {
  name = "disagguatspot"
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 30
      volume_type = "gp2"

    }
  }
  iam_instance_profile {
    name = "uat-iam-instance-profile"
  }

  image_id = "ami-001687ed21bf26dda"
  key_name = "uat"

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = "subnet-726ea80b"
    security_groups             = ["sg-08039c77"]

  }

  placement {
    availability_zone = "us-west-2a"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "daemons-avista"
    }
  }
}
resource "aws_spot_fleet_request" "cheap_compute_disagg" {
  iam_fleet_role      = "arn:aws:iam::189675173661:role/aws-ec2-spot-fleet-tagging-role"
  spot_price          = "0.03"
  allocation_strategy = "lowestPrice"
  target_capacity     = 1
  valid_until         = "2023-11-04T20:44:20Z"


  launch_specification {
    instance_type          = "m4.10xlarge"
    ami                    = "ami-001687ed21bf26dda"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("disagg.sh"))}"

  }
  launch_specification {
    instance_type          = "m4.xlarge"
    ami                    = "ami-001687ed21bf26dda"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("disagg.sh"))}"

  }
  launch_specification {
    instance_type          = "m4.2xlarge"
    ami                    = "ami-001687ed21bf26dda"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("disagg.sh"))}"

  }

  launch_specification {
    instance_type          = "m4.4xlarge"
    ami                    = "ami-001687ed21bf26dda"
    key_name               = "uat"
    spot_price             = "0.366"
    placement_tenancy      = "default"
    iam_instance_profile   = "uat-iam-instance-profile"
    availability_zone      = "us-west-2a"
    subnet_id              = "subnet-726ea80b"
    vpc_security_group_ids = ["sg-08039c77"]
    user_data              = "${base64encode(file("disagg.sh"))}"

    tags = {
      Name = "pyamidisagg"
    }
  }
}
resource "aws_launch_template" "ingesterjobsamerenlaunchtemplate" {
  name = "ingesterjobsamerenlaunchtemplate"
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 30
      volume_type = "gp2"

    }
  }
  iam_instance_profile {
    name = "uat-iam-instance-profile"
  }

  image_id      = "ami-6672ff1e"
  user_data     = "${base64encode(file("ingesterameren.sh"))}"
  instance_type = "m4.xlarge"
  key_name      = "uat"

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = "subnet-726ea80b"
    security_groups             = ["sg-08039c77"]

  }

  placement {
    availability_zone = "us-west-2a"
  }


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ingesterjobs"
    }
  }
}
resource "aws_autoscaling_group" "ingesterjobs-od-asg-ameren" {
  availability_zones = ["us-west-2a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  launch_template {
    id      = aws_launch_template.ingesterjobsamerenlaunchtemplate.id
    version = "$Latest"
  }
}
resource "aws_launch_template" "aggregationsamerenlaunchtemplate" {
  name = "aggregationsamerenlaunchtemplate"
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 30
      volume_type = "gp2"

    }
  }
  iam_instance_profile {
    name = "uat-iam-instance-profile"
  }

  image_id      = "ami-6672ff1e"
  user_data     = "${base64encode(file("aggregationsameren.sh"))}"
  instance_type = "m4.xlarge"
  key_name      = "uat"

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = "subnet-726ea80b"
    security_groups             = ["sg-08039c77"]

  }

  placement {
    availability_zone = "us-west-2a"
  }


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "aggregations"
    }
  }
}
resource "aws_autoscaling_group" "aggregations-od-asg-ameren" {
  availability_zones = ["us-west-2a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  launch_template {
    id      = aws_launch_template.aggregationsamerenlaunchtemplate.id
    version = "$Latest"
  }
}
