resource "aws_launch_template" "ingesterjobs-testlaunchtemplate" {
  name = "ingesterjobs-testlaunchtemplate"
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 30
      volume_type = "gp2"

    }
  }
  iam_instance_profile {
    name = "prodca-iam-instance-profile"
  }
  image_id      = "ami-0dcf9abdc83d6e6f7"
  user_data     = base64encode(file("ingester.sh"))
  instance_type = "m4.xlarge"
  key_name      = "prodca"

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = "subnet-0b203fd84612bcbd1"
    security_groups             = ["sg-0a3db65a3dad9644f"]
  }
  placement {
    availability_zone = "ca-central-1a"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ingesterjobs-test"
    }
  }
}
resource "aws_autoscaling_group" "ingesterjobs-test-od-asg-prodca" {
  capacity_rebalance = true
  availability_zones = ["ca-central-1a"]
  desired_capacity   = 10
  max_size           = 20
  min_size           = 5
  health_check_type  = "EC2"
  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 0
      spot_allocation_strategy                 = "lowest-price"
    }
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.ingesterjobs-testlaunchtemplate.id
      }
      override {
        instance_type     = "c4.large"
        weighted_capacity = "3"
      }
      override {
        instance_type     = "c5.xlarge"
        weighted_capacity = "2"
      }
    }
  }
}
resource "aws_autoscaling_policy" "agents-scale-up" {
  name                   = "agents-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ingesterjobs-test-od-asg-prodca.name
}
resource "aws_autoscaling_policy" "agents-scale-down" {
  name                   = "agents-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ingesterjobs-test-od-asg-prodca.name
}
resource "aws_cloudwatch_metric_alarm" "memory-high" {
  alarm_name          = "ingester-scaleup"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = "300"
  statistic           = "Average"
  threshold           = "20000"
  alarm_description   = "This metric monitors ec2 memory for high utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.agents-scale-up.arn}"
  ]
  dimensions = {
    autoscaling_group_name = "${aws_autoscaling_group.ingesterjobs-test-od-asg-prodca.name}"
    QueueName              = "AggregationReadyUsers-prod-ca-tmp"
  }
}
resource "aws_cloudwatch_metric_alarm" "memory-low" {
  alarm_name          = "ingester-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "ApproximateNumberOfMessagesNotVisible"
  namespace           = "AWS/SQS"
  period              = "300"
  statistic           = "Average"
  threshold           = "40"
  alarm_description   = "This metric monitors ec2 memory for low utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.agents-scale-down.arn}"
  ]
  dimensions = {
    autoscaling_group_name = "${aws_autoscaling_group.ingesterjobs-test-od-asg-prodca.name}"
    QueueName              = "AggregationReadyUsers-prod-ca-tmp"
  }
}
